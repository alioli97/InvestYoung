import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/profile/data/backup_files.dart';
import 'package:invest_young/features/profile/data/backup_service.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/test_database.dart';

class _FakeFiles implements BackupFiles {
  String? shared;
  String? sharedName;
  String? sharedType;
  String? toPick;

  @override
  Future<void> share(
    String content,
    String fileName, {
    String mimeType = 'application/json',
  }) async {
    shared = content;
    sharedName = fileName;
    sharedType = mimeType;
  }

  @override
  Future<String?> pick() async => toPick;
}

void main() {
  late AppDatabase db;
  late _FakeFiles files;

  setUp(() {
    db = createTestDatabase();
    files = _FakeFiles();
  });

  Future<void> openProfile(WidgetTester tester) async {
    final profile = onboardedProfile();
    await tester.runAsync(
      () => ProfileRepository(db.profileDao).saveProfile(profile),
    );
    await pumpApp(
      tester,
      database: db,
      startupProfile: profile,
      overrides: [backupFilesProvider.overrideWithValue(files)],
    );
    await tapVisible(tester, find.text('Perfil'));
  }

  testWidgets('exports a JSON backup', (tester) async {
    await openProfile(tester);
    await tester.runAsync(() async {
      await tester.tap(find.text('Exportar copia de seguridad'));
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pumpAndSettle();

    expect(
      files.sharedName,
      matches(RegExp(r'^invest-young-backup-\d{4}-\d\d-\d\d\.json$')),
    );
    final json = jsonDecode(files.shared!) as Map<String, dynamic>;
    expect(json['app'], 'invest_young');
    expect((json['tables'] as Map)['user_profiles'], hasLength(1));
  });

  Future<void> tapExportCsv(WidgetTester tester) async {
    await tester.ensureVisible(find.text('Exportar movimientos (CSV)'));
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      await tester.tap(find.text('Exportar movimientos (CSV)'));
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pumpAndSettle();
  }

  testWidgets('exports the transactions as CSV in the app language', (
    tester,
  ) async {
    await tester.runAsync(() async {
      final investments = InvestmentsRepository(db.investmentsDao);
      final id = await investments.addAsset(
        testAsset(AssetCategory.equity, name: 'Fondo'),
      );
      await investments.addTransaction(
        testTx(id, TransactionType.buy, 150050, quantity: '2.5'),
      );
    });
    await openProfile(tester);
    await tapExportCsv(tester);

    expect(
      files.sharedName,
      matches(RegExp(r'^invest-young-transactions-\d{4}-\d\d-\d\d\.csv$')),
    );
    expect(files.sharedType, 'text/csv');
    final rows = files.shared!.substring(1).split('\r\n');
    expect(rows.first, startsWith('Fecha;Activo;Categoría;Tipo;Importe (€)'));
    expect(rows[1], contains(';Fondo;Renta variable;Compra;1500,50;2,5;'));
  });

  testWidgets('says there is nothing to export without transactions', (
    tester,
  ) async {
    await openProfile(tester);
    await tapExportCsv(tester);

    expect(files.shared, isNull);
    expect(
      find.text('Todavía no hay movimientos que exportar'),
      findsOneWidget,
    );
  });

  testWidgets('imports a backup after confirmation', (tester) async {
    final other = createTestDatabase();
    addTearDown(other.close);
    files.toPick = (await tester.runAsync(() async {
      await ProfileRepository(other.profileDao)
          .saveProfile(onboardedProfile(locale: 'ca'));
      await GoalsRepository(other.goalsDao).addGoal(
        Goal(
          type: GoalType.custom,
          name: 'Viatge',
          targetCents: 100000,
          createdAt: DateTime.utc(2026),
        ),
      );
      return BackupService(other).exportJson();
    }))!;

    await openProfile(tester);
    await tapVisible(tester, find.text('Importar copia de seguridad'));
    expect(find.text('¿Reemplazar todos tus datos?'), findsOneWidget);
    await tapVisible(tester, find.text('Reemplazar'));

    // The confirmation uses the language at the time of the action; the
    // app then switches to the imported profile's language (Catalan).
    expect(find.text('Copia importada'), findsOneWidget);
    expect(find.text('Les teves dades'), findsOneWidget);
    final goals = (await tester.runAsync(
      GoalsRepository(db.goalsDao).getGoals,
    ))!;
    expect(goals.single.name, 'Viatge');
  });

  testWidgets('cancelling the import changes nothing', (tester) async {
    files.toPick = '{}';
    await openProfile(tester);
    await tapVisible(tester, find.text('Importar copia de seguridad'));
    await tapVisible(tester, find.text('Cancelar'));
    expect(find.text('Perfil'), findsWidgets);
    expect(find.textContaining('No se ha cambiado nada'), findsNothing);
  });

  testWidgets('an invalid file shows an error', (tester) async {
    files.toPick = '{"app": "other"}';
    await openProfile(tester);
    await tapVisible(tester, find.text('Importar copia de seguridad'));
    await tapVisible(tester, find.text('Reemplazar'));
    expect(
      find.text(
        'El archivo no es una copia válida de la app. No se ha cambiado nada.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('deleting all data returns to onboarding', (tester) async {
    await openProfile(tester);
    await tapVisible(tester, find.text('Borrar todos los datos'));
    expect(find.text('¿Borrar todos los datos?'), findsOneWidget);
    await tapVisible(tester, find.text('Borrar todo'));

    expect(find.text('Paso 1 de 8'), findsOneWidget);
    expect(
      await tester.runAsync(ProfileRepository(db.profileDao).getProfile),
      isNull,
    );
  });
}
