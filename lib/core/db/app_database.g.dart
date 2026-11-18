// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AgeRange, String> ageRange =
      GeneratedColumn<String>(
        'age_range',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AgeRange>($UserProfilesTable.$converterageRange);
  @override
  late final GeneratedColumnWithTypeConverter<Employment, String> employment =
      GeneratedColumn<String>(
        'employment',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Employment>($UserProfilesTable.$converteremployment);
  static const VerificationMeta _monthlyIncomeCentsMeta =
      const VerificationMeta('monthlyIncomeCents');
  @override
  late final GeneratedColumn<int> monthlyIncomeCents = GeneratedColumn<int>(
    'monthly_income_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasDependentsMeta = const VerificationMeta(
    'hasDependents',
  );
  @override
  late final GeneratedColumn<bool> hasDependents = GeneratedColumn<bool>(
    'has_dependents',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_dependents" IN (0, 1))',
    ),
  );
  static const VerificationMeta _hasHighInterestDebtMeta =
      const VerificationMeta('hasHighInterestDebt');
  @override
  late final GeneratedColumn<bool> hasHighInterestDebt = GeneratedColumn<bool>(
    'has_high_interest_debt',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_high_interest_debt" IN (0, 1))',
    ),
  );
  static const VerificationMeta _debtCentsMeta = const VerificationMeta(
    'debtCents',
  );
  @override
  late final GeneratedColumn<int> debtCents = GeneratedColumn<int>(
    'debt_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _riskScoreMeta = const VerificationMeta(
    'riskScore',
  );
  @override
  late final GeneratedColumn<int> riskScore = GeneratedColumn<int>(
    'risk_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RiskProfile, String> riskProfile =
      GeneratedColumn<String>(
        'risk_profile',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RiskProfile>($UserProfilesTable.$converterriskProfile);
  @override
  late final GeneratedColumnWithTypeConverter<KnowledgeLevel, String>
  knowledgeLevel = GeneratedColumn<String>(
    'knowledge_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<KnowledgeLevel>($UserProfilesTable.$converterknowledgeLevel);
  static const VerificationMeta _emergencyMonthsMeta = const VerificationMeta(
    'emergencyMonths',
  );
  @override
  late final GeneratedColumn<int> emergencyMonths = GeneratedColumn<int>(
    'emergency_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _onboardingCompletedAtMeta =
      const VerificationMeta('onboardingCompletedAt');
  @override
  late final GeneratedColumn<DateTime> onboardingCompletedAt =
      GeneratedColumn<DateTime>(
        'onboarding_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<AppThemeMode, String> themeMode =
      GeneratedColumn<String>(
        'theme_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('system'),
      ).withConverter<AppThemeMode>($UserProfilesTable.$converterthemeMode);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ageRange,
    employment,
    monthlyIncomeCents,
    hasDependents,
    hasHighInterestDebt,
    debtCents,
    riskScore,
    riskProfile,
    knowledgeLevel,
    emergencyMonths,
    locale,
    onboardingCompletedAt,
    themeMode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monthly_income_cents')) {
      context.handle(
        _monthlyIncomeCentsMeta,
        monthlyIncomeCents.isAcceptableOrUnknown(
          data['monthly_income_cents']!,
          _monthlyIncomeCentsMeta,
        ),
      );
    }
    if (data.containsKey('has_dependents')) {
      context.handle(
        _hasDependentsMeta,
        hasDependents.isAcceptableOrUnknown(
          data['has_dependents']!,
          _hasDependentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hasDependentsMeta);
    }
    if (data.containsKey('has_high_interest_debt')) {
      context.handle(
        _hasHighInterestDebtMeta,
        hasHighInterestDebt.isAcceptableOrUnknown(
          data['has_high_interest_debt']!,
          _hasHighInterestDebtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hasHighInterestDebtMeta);
    }
    if (data.containsKey('debt_cents')) {
      context.handle(
        _debtCentsMeta,
        debtCents.isAcceptableOrUnknown(data['debt_cents']!, _debtCentsMeta),
      );
    }
    if (data.containsKey('risk_score')) {
      context.handle(
        _riskScoreMeta,
        riskScore.isAcceptableOrUnknown(data['risk_score']!, _riskScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_riskScoreMeta);
    }
    if (data.containsKey('emergency_months')) {
      context.handle(
        _emergencyMonthsMeta,
        emergencyMonths.isAcceptableOrUnknown(
          data['emergency_months']!,
          _emergencyMonthsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emergencyMonthsMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('onboarding_completed_at')) {
      context.handle(
        _onboardingCompletedAtMeta,
        onboardingCompletedAt.isAcceptableOrUnknown(
          data['onboarding_completed_at']!,
          _onboardingCompletedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ageRange: $UserProfilesTable.$converterageRange.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}age_range'],
        )!,
      ),
      employment: $UserProfilesTable.$converteremployment.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}employment'],
        )!,
      ),
      monthlyIncomeCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_income_cents'],
      ),
      hasDependents: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_dependents'],
      )!,
      hasHighInterestDebt: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_high_interest_debt'],
      )!,
      debtCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}debt_cents'],
      ),
      riskScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}risk_score'],
      )!,
      riskProfile: $UserProfilesTable.$converterriskProfile.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}risk_profile'],
        )!,
      ),
      knowledgeLevel: $UserProfilesTable.$converterknowledgeLevel.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}knowledge_level'],
        )!,
      ),
      emergencyMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}emergency_months'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      onboardingCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}onboarding_completed_at'],
      ),
      themeMode: $UserProfilesTable.$converterthemeMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_mode'],
        )!,
      ),
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }

  static TypeConverter<AgeRange, String> $converterageRange =
      const DbEnumConverter(AgeRange.values);
  static TypeConverter<Employment, String> $converteremployment =
      const DbEnumConverter(Employment.values);
  static TypeConverter<RiskProfile, String> $converterriskProfile =
      const DbEnumConverter(RiskProfile.values);
  static TypeConverter<KnowledgeLevel, String> $converterknowledgeLevel =
      const DbEnumConverter(KnowledgeLevel.values);
  static TypeConverter<AppThemeMode, String> $converterthemeMode =
      const DbEnumConverter(AppThemeMode.values);
}

class UserProfileRow extends DataClass implements Insertable<UserProfileRow> {
  final int id;
  final AgeRange ageRange;
  final Employment employment;
  final int? monthlyIncomeCents;
  final bool hasDependents;
  final bool hasHighInterestDebt;
  final int? debtCents;
  final int riskScore;
  final RiskProfile riskProfile;
  final KnowledgeLevel knowledgeLevel;
  final int emergencyMonths;
  final String locale;
  final DateTime? onboardingCompletedAt;

  /// Added in schema v2.
  final AppThemeMode themeMode;
  const UserProfileRow({
    required this.id,
    required this.ageRange,
    required this.employment,
    this.monthlyIncomeCents,
    required this.hasDependents,
    required this.hasHighInterestDebt,
    this.debtCents,
    required this.riskScore,
    required this.riskProfile,
    required this.knowledgeLevel,
    required this.emergencyMonths,
    required this.locale,
    this.onboardingCompletedAt,
    required this.themeMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['age_range'] = Variable<String>(
        $UserProfilesTable.$converterageRange.toSql(ageRange),
      );
    }
    {
      map['employment'] = Variable<String>(
        $UserProfilesTable.$converteremployment.toSql(employment),
      );
    }
    if (!nullToAbsent || monthlyIncomeCents != null) {
      map['monthly_income_cents'] = Variable<int>(monthlyIncomeCents);
    }
    map['has_dependents'] = Variable<bool>(hasDependents);
    map['has_high_interest_debt'] = Variable<bool>(hasHighInterestDebt);
    if (!nullToAbsent || debtCents != null) {
      map['debt_cents'] = Variable<int>(debtCents);
    }
    map['risk_score'] = Variable<int>(riskScore);
    {
      map['risk_profile'] = Variable<String>(
        $UserProfilesTable.$converterriskProfile.toSql(riskProfile),
      );
    }
    {
      map['knowledge_level'] = Variable<String>(
        $UserProfilesTable.$converterknowledgeLevel.toSql(knowledgeLevel),
      );
    }
    map['emergency_months'] = Variable<int>(emergencyMonths);
    map['locale'] = Variable<String>(locale);
    if (!nullToAbsent || onboardingCompletedAt != null) {
      map['onboarding_completed_at'] = Variable<DateTime>(
        onboardingCompletedAt,
      );
    }
    {
      map['theme_mode'] = Variable<String>(
        $UserProfilesTable.$converterthemeMode.toSql(themeMode),
      );
    }
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      ageRange: Value(ageRange),
      employment: Value(employment),
      monthlyIncomeCents: monthlyIncomeCents == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyIncomeCents),
      hasDependents: Value(hasDependents),
      hasHighInterestDebt: Value(hasHighInterestDebt),
      debtCents: debtCents == null && nullToAbsent
          ? const Value.absent()
          : Value(debtCents),
      riskScore: Value(riskScore),
      riskProfile: Value(riskProfile),
      knowledgeLevel: Value(knowledgeLevel),
      emergencyMonths: Value(emergencyMonths),
      locale: Value(locale),
      onboardingCompletedAt: onboardingCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(onboardingCompletedAt),
      themeMode: Value(themeMode),
    );
  }

  factory UserProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileRow(
      id: serializer.fromJson<int>(json['id']),
      ageRange: serializer.fromJson<AgeRange>(json['ageRange']),
      employment: serializer.fromJson<Employment>(json['employment']),
      monthlyIncomeCents: serializer.fromJson<int?>(json['monthlyIncomeCents']),
      hasDependents: serializer.fromJson<bool>(json['hasDependents']),
      hasHighInterestDebt: serializer.fromJson<bool>(
        json['hasHighInterestDebt'],
      ),
      debtCents: serializer.fromJson<int?>(json['debtCents']),
      riskScore: serializer.fromJson<int>(json['riskScore']),
      riskProfile: serializer.fromJson<RiskProfile>(json['riskProfile']),
      knowledgeLevel: serializer.fromJson<KnowledgeLevel>(
        json['knowledgeLevel'],
      ),
      emergencyMonths: serializer.fromJson<int>(json['emergencyMonths']),
      locale: serializer.fromJson<String>(json['locale']),
      onboardingCompletedAt: serializer.fromJson<DateTime?>(
        json['onboardingCompletedAt'],
      ),
      themeMode: serializer.fromJson<AppThemeMode>(json['themeMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ageRange': serializer.toJson<AgeRange>(ageRange),
      'employment': serializer.toJson<Employment>(employment),
      'monthlyIncomeCents': serializer.toJson<int?>(monthlyIncomeCents),
      'hasDependents': serializer.toJson<bool>(hasDependents),
      'hasHighInterestDebt': serializer.toJson<bool>(hasHighInterestDebt),
      'debtCents': serializer.toJson<int?>(debtCents),
      'riskScore': serializer.toJson<int>(riskScore),
      'riskProfile': serializer.toJson<RiskProfile>(riskProfile),
      'knowledgeLevel': serializer.toJson<KnowledgeLevel>(knowledgeLevel),
      'emergencyMonths': serializer.toJson<int>(emergencyMonths),
      'locale': serializer.toJson<String>(locale),
      'onboardingCompletedAt': serializer.toJson<DateTime?>(
        onboardingCompletedAt,
      ),
      'themeMode': serializer.toJson<AppThemeMode>(themeMode),
    };
  }

  UserProfileRow copyWith({
    int? id,
    AgeRange? ageRange,
    Employment? employment,
    Value<int?> monthlyIncomeCents = const Value.absent(),
    bool? hasDependents,
    bool? hasHighInterestDebt,
    Value<int?> debtCents = const Value.absent(),
    int? riskScore,
    RiskProfile? riskProfile,
    KnowledgeLevel? knowledgeLevel,
    int? emergencyMonths,
    String? locale,
    Value<DateTime?> onboardingCompletedAt = const Value.absent(),
    AppThemeMode? themeMode,
  }) => UserProfileRow(
    id: id ?? this.id,
    ageRange: ageRange ?? this.ageRange,
    employment: employment ?? this.employment,
    monthlyIncomeCents: monthlyIncomeCents.present
        ? monthlyIncomeCents.value
        : this.monthlyIncomeCents,
    hasDependents: hasDependents ?? this.hasDependents,
    hasHighInterestDebt: hasHighInterestDebt ?? this.hasHighInterestDebt,
    debtCents: debtCents.present ? debtCents.value : this.debtCents,
    riskScore: riskScore ?? this.riskScore,
    riskProfile: riskProfile ?? this.riskProfile,
    knowledgeLevel: knowledgeLevel ?? this.knowledgeLevel,
    emergencyMonths: emergencyMonths ?? this.emergencyMonths,
    locale: locale ?? this.locale,
    onboardingCompletedAt: onboardingCompletedAt.present
        ? onboardingCompletedAt.value
        : this.onboardingCompletedAt,
    themeMode: themeMode ?? this.themeMode,
  );
  UserProfileRow copyWithCompanion(UserProfilesCompanion data) {
    return UserProfileRow(
      id: data.id.present ? data.id.value : this.id,
      ageRange: data.ageRange.present ? data.ageRange.value : this.ageRange,
      employment: data.employment.present
          ? data.employment.value
          : this.employment,
      monthlyIncomeCents: data.monthlyIncomeCents.present
          ? data.monthlyIncomeCents.value
          : this.monthlyIncomeCents,
      hasDependents: data.hasDependents.present
          ? data.hasDependents.value
          : this.hasDependents,
      hasHighInterestDebt: data.hasHighInterestDebt.present
          ? data.hasHighInterestDebt.value
          : this.hasHighInterestDebt,
      debtCents: data.debtCents.present ? data.debtCents.value : this.debtCents,
      riskScore: data.riskScore.present ? data.riskScore.value : this.riskScore,
      riskProfile: data.riskProfile.present
          ? data.riskProfile.value
          : this.riskProfile,
      knowledgeLevel: data.knowledgeLevel.present
          ? data.knowledgeLevel.value
          : this.knowledgeLevel,
      emergencyMonths: data.emergencyMonths.present
          ? data.emergencyMonths.value
          : this.emergencyMonths,
      locale: data.locale.present ? data.locale.value : this.locale,
      onboardingCompletedAt: data.onboardingCompletedAt.present
          ? data.onboardingCompletedAt.value
          : this.onboardingCompletedAt,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileRow(')
          ..write('id: $id, ')
          ..write('ageRange: $ageRange, ')
          ..write('employment: $employment, ')
          ..write('monthlyIncomeCents: $monthlyIncomeCents, ')
          ..write('hasDependents: $hasDependents, ')
          ..write('hasHighInterestDebt: $hasHighInterestDebt, ')
          ..write('debtCents: $debtCents, ')
          ..write('riskScore: $riskScore, ')
          ..write('riskProfile: $riskProfile, ')
          ..write('knowledgeLevel: $knowledgeLevel, ')
          ..write('emergencyMonths: $emergencyMonths, ')
          ..write('locale: $locale, ')
          ..write('onboardingCompletedAt: $onboardingCompletedAt, ')
          ..write('themeMode: $themeMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ageRange,
    employment,
    monthlyIncomeCents,
    hasDependents,
    hasHighInterestDebt,
    debtCents,
    riskScore,
    riskProfile,
    knowledgeLevel,
    emergencyMonths,
    locale,
    onboardingCompletedAt,
    themeMode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileRow &&
          other.id == this.id &&
          other.ageRange == this.ageRange &&
          other.employment == this.employment &&
          other.monthlyIncomeCents == this.monthlyIncomeCents &&
          other.hasDependents == this.hasDependents &&
          other.hasHighInterestDebt == this.hasHighInterestDebt &&
          other.debtCents == this.debtCents &&
          other.riskScore == this.riskScore &&
          other.riskProfile == this.riskProfile &&
          other.knowledgeLevel == this.knowledgeLevel &&
          other.emergencyMonths == this.emergencyMonths &&
          other.locale == this.locale &&
          other.onboardingCompletedAt == this.onboardingCompletedAt &&
          other.themeMode == this.themeMode);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfileRow> {
  final Value<int> id;
  final Value<AgeRange> ageRange;
  final Value<Employment> employment;
  final Value<int?> monthlyIncomeCents;
  final Value<bool> hasDependents;
  final Value<bool> hasHighInterestDebt;
  final Value<int?> debtCents;
  final Value<int> riskScore;
  final Value<RiskProfile> riskProfile;
  final Value<KnowledgeLevel> knowledgeLevel;
  final Value<int> emergencyMonths;
  final Value<String> locale;
  final Value<DateTime?> onboardingCompletedAt;
  final Value<AppThemeMode> themeMode;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.ageRange = const Value.absent(),
    this.employment = const Value.absent(),
    this.monthlyIncomeCents = const Value.absent(),
    this.hasDependents = const Value.absent(),
    this.hasHighInterestDebt = const Value.absent(),
    this.debtCents = const Value.absent(),
    this.riskScore = const Value.absent(),
    this.riskProfile = const Value.absent(),
    this.knowledgeLevel = const Value.absent(),
    this.emergencyMonths = const Value.absent(),
    this.locale = const Value.absent(),
    this.onboardingCompletedAt = const Value.absent(),
    this.themeMode = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required AgeRange ageRange,
    required Employment employment,
    this.monthlyIncomeCents = const Value.absent(),
    required bool hasDependents,
    required bool hasHighInterestDebt,
    this.debtCents = const Value.absent(),
    required int riskScore,
    required RiskProfile riskProfile,
    required KnowledgeLevel knowledgeLevel,
    required int emergencyMonths,
    required String locale,
    this.onboardingCompletedAt = const Value.absent(),
    this.themeMode = const Value.absent(),
  }) : ageRange = Value(ageRange),
       employment = Value(employment),
       hasDependents = Value(hasDependents),
       hasHighInterestDebt = Value(hasHighInterestDebt),
       riskScore = Value(riskScore),
       riskProfile = Value(riskProfile),
       knowledgeLevel = Value(knowledgeLevel),
       emergencyMonths = Value(emergencyMonths),
       locale = Value(locale);
  static Insertable<UserProfileRow> custom({
    Expression<int>? id,
    Expression<String>? ageRange,
    Expression<String>? employment,
    Expression<int>? monthlyIncomeCents,
    Expression<bool>? hasDependents,
    Expression<bool>? hasHighInterestDebt,
    Expression<int>? debtCents,
    Expression<int>? riskScore,
    Expression<String>? riskProfile,
    Expression<String>? knowledgeLevel,
    Expression<int>? emergencyMonths,
    Expression<String>? locale,
    Expression<DateTime>? onboardingCompletedAt,
    Expression<String>? themeMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ageRange != null) 'age_range': ageRange,
      if (employment != null) 'employment': employment,
      if (monthlyIncomeCents != null)
        'monthly_income_cents': monthlyIncomeCents,
      if (hasDependents != null) 'has_dependents': hasDependents,
      if (hasHighInterestDebt != null)
        'has_high_interest_debt': hasHighInterestDebt,
      if (debtCents != null) 'debt_cents': debtCents,
      if (riskScore != null) 'risk_score': riskScore,
      if (riskProfile != null) 'risk_profile': riskProfile,
      if (knowledgeLevel != null) 'knowledge_level': knowledgeLevel,
      if (emergencyMonths != null) 'emergency_months': emergencyMonths,
      if (locale != null) 'locale': locale,
      if (onboardingCompletedAt != null)
        'onboarding_completed_at': onboardingCompletedAt,
      if (themeMode != null) 'theme_mode': themeMode,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<AgeRange>? ageRange,
    Value<Employment>? employment,
    Value<int?>? monthlyIncomeCents,
    Value<bool>? hasDependents,
    Value<bool>? hasHighInterestDebt,
    Value<int?>? debtCents,
    Value<int>? riskScore,
    Value<RiskProfile>? riskProfile,
    Value<KnowledgeLevel>? knowledgeLevel,
    Value<int>? emergencyMonths,
    Value<String>? locale,
    Value<DateTime?>? onboardingCompletedAt,
    Value<AppThemeMode>? themeMode,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      ageRange: ageRange ?? this.ageRange,
      employment: employment ?? this.employment,
      monthlyIncomeCents: monthlyIncomeCents ?? this.monthlyIncomeCents,
      hasDependents: hasDependents ?? this.hasDependents,
      hasHighInterestDebt: hasHighInterestDebt ?? this.hasHighInterestDebt,
      debtCents: debtCents ?? this.debtCents,
      riskScore: riskScore ?? this.riskScore,
      riskProfile: riskProfile ?? this.riskProfile,
      knowledgeLevel: knowledgeLevel ?? this.knowledgeLevel,
      emergencyMonths: emergencyMonths ?? this.emergencyMonths,
      locale: locale ?? this.locale,
      onboardingCompletedAt:
          onboardingCompletedAt ?? this.onboardingCompletedAt,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ageRange.present) {
      map['age_range'] = Variable<String>(
        $UserProfilesTable.$converterageRange.toSql(ageRange.value),
      );
    }
    if (employment.present) {
      map['employment'] = Variable<String>(
        $UserProfilesTable.$converteremployment.toSql(employment.value),
      );
    }
    if (monthlyIncomeCents.present) {
      map['monthly_income_cents'] = Variable<int>(monthlyIncomeCents.value);
    }
    if (hasDependents.present) {
      map['has_dependents'] = Variable<bool>(hasDependents.value);
    }
    if (hasHighInterestDebt.present) {
      map['has_high_interest_debt'] = Variable<bool>(hasHighInterestDebt.value);
    }
    if (debtCents.present) {
      map['debt_cents'] = Variable<int>(debtCents.value);
    }
    if (riskScore.present) {
      map['risk_score'] = Variable<int>(riskScore.value);
    }
    if (riskProfile.present) {
      map['risk_profile'] = Variable<String>(
        $UserProfilesTable.$converterriskProfile.toSql(riskProfile.value),
      );
    }
    if (knowledgeLevel.present) {
      map['knowledge_level'] = Variable<String>(
        $UserProfilesTable.$converterknowledgeLevel.toSql(knowledgeLevel.value),
      );
    }
    if (emergencyMonths.present) {
      map['emergency_months'] = Variable<int>(emergencyMonths.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (onboardingCompletedAt.present) {
      map['onboarding_completed_at'] = Variable<DateTime>(
        onboardingCompletedAt.value,
      );
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(
        $UserProfilesTable.$converterthemeMode.toSql(themeMode.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('ageRange: $ageRange, ')
          ..write('employment: $employment, ')
          ..write('monthlyIncomeCents: $monthlyIncomeCents, ')
          ..write('hasDependents: $hasDependents, ')
          ..write('hasHighInterestDebt: $hasHighInterestDebt, ')
          ..write('debtCents: $debtCents, ')
          ..write('riskScore: $riskScore, ')
          ..write('riskProfile: $riskProfile, ')
          ..write('knowledgeLevel: $knowledgeLevel, ')
          ..write('emergencyMonths: $emergencyMonths, ')
          ..write('locale: $locale, ')
          ..write('onboardingCompletedAt: $onboardingCompletedAt, ')
          ..write('themeMode: $themeMode')
          ..write(')'))
        .toString();
  }
}

class $MonthlyExpensesTable extends MonthlyExpenses
    with TableInfo<$MonthlyExpensesTable, MonthlyExpenseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ExpenseCategory>($MonthlyExpensesTable.$convertercategory);
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, category, amountCents];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyExpenseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlyExpenseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyExpenseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: $MonthlyExpensesTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
    );
  }

  @override
  $MonthlyExpensesTable createAlias(String alias) {
    return $MonthlyExpensesTable(attachedDatabase, alias);
  }

  static TypeConverter<ExpenseCategory, String> $convertercategory =
      const DbEnumConverter(ExpenseCategory.values);
}

class MonthlyExpenseRow extends DataClass
    implements Insertable<MonthlyExpenseRow> {
  final int id;
  final ExpenseCategory category;
  final int amountCents;
  const MonthlyExpenseRow({
    required this.id,
    required this.category,
    required this.amountCents,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['category'] = Variable<String>(
        $MonthlyExpensesTable.$convertercategory.toSql(category),
      );
    }
    map['amount_cents'] = Variable<int>(amountCents);
    return map;
  }

  MonthlyExpensesCompanion toCompanion(bool nullToAbsent) {
    return MonthlyExpensesCompanion(
      id: Value(id),
      category: Value(category),
      amountCents: Value(amountCents),
    );
  }

  factory MonthlyExpenseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyExpenseRow(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<ExpenseCategory>(json['category']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<ExpenseCategory>(category),
      'amountCents': serializer.toJson<int>(amountCents),
    };
  }

  MonthlyExpenseRow copyWith({
    int? id,
    ExpenseCategory? category,
    int? amountCents,
  }) => MonthlyExpenseRow(
    id: id ?? this.id,
    category: category ?? this.category,
    amountCents: amountCents ?? this.amountCents,
  );
  MonthlyExpenseRow copyWithCompanion(MonthlyExpensesCompanion data) {
    return MonthlyExpenseRow(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyExpenseRow(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, amountCents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyExpenseRow &&
          other.id == this.id &&
          other.category == this.category &&
          other.amountCents == this.amountCents);
}

class MonthlyExpensesCompanion extends UpdateCompanion<MonthlyExpenseRow> {
  final Value<int> id;
  final Value<ExpenseCategory> category;
  final Value<int> amountCents;
  const MonthlyExpensesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.amountCents = const Value.absent(),
  });
  MonthlyExpensesCompanion.insert({
    this.id = const Value.absent(),
    required ExpenseCategory category,
    required int amountCents,
  }) : category = Value(category),
       amountCents = Value(amountCents);
  static Insertable<MonthlyExpenseRow> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<int>? amountCents,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (amountCents != null) 'amount_cents': amountCents,
    });
  }

  MonthlyExpensesCompanion copyWith({
    Value<int>? id,
    Value<ExpenseCategory>? category,
    Value<int>? amountCents,
  }) {
    return MonthlyExpensesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      amountCents: amountCents ?? this.amountCents,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $MonthlyExpensesTable.$convertercategory.toSql(category.value),
      );
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyExpensesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, GoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GoalType>($GoalsTable.$convertertype);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCentsMeta = const VerificationMeta(
    'targetCents',
  );
  @override
  late final GeneratedColumn<int> targetCents = GeneratedColumn<int>(
    'target_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedAnnualReturnMeta =
      const VerificationMeta('expectedAnnualReturn');
  @override
  late final GeneratedColumn<double> expectedAnnualReturn =
      GeneratedColumn<double>(
        'expected_annual_return',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _paramsJsonMeta = const VerificationMeta(
    'paramsJson',
  );
  @override
  late final GeneratedColumn<String> paramsJson = GeneratedColumn<String>(
    'params_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    name,
    targetCents,
    targetDate,
    expectedAnnualReturn,
    paramsJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_cents')) {
      context.handle(
        _targetCentsMeta,
        targetCents.isAcceptableOrUnknown(
          data['target_cents']!,
          _targetCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCentsMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('expected_annual_return')) {
      context.handle(
        _expectedAnnualReturnMeta,
        expectedAnnualReturn.isAcceptableOrUnknown(
          data['expected_annual_return']!,
          _expectedAnnualReturnMeta,
        ),
      );
    }
    if (data.containsKey('params_json')) {
      context.handle(
        _paramsJsonMeta,
        paramsJson.isAcceptableOrUnknown(data['params_json']!, _paramsJsonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $GoalsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      targetCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_cents'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      expectedAnnualReturn: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_annual_return'],
      )!,
      paramsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}params_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }

  static TypeConverter<GoalType, String> $convertertype = const DbEnumConverter(
    GoalType.values,
  );
}

class GoalRow extends DataClass implements Insertable<GoalRow> {
  final int id;
  final GoalType type;
  final String name;
  final int targetCents;
  final DateTime? targetDate;
  final double expectedAnnualReturn;
  final String paramsJson;
  final DateTime createdAt;
  const GoalRow({
    required this.id,
    required this.type,
    required this.name,
    required this.targetCents,
    this.targetDate,
    required this.expectedAnnualReturn,
    required this.paramsJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>($GoalsTable.$convertertype.toSql(type));
    }
    map['name'] = Variable<String>(name);
    map['target_cents'] = Variable<int>(targetCents);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    map['expected_annual_return'] = Variable<double>(expectedAnnualReturn);
    map['params_json'] = Variable<String>(paramsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      type: Value(type),
      name: Value(name),
      targetCents: Value(targetCents),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      expectedAnnualReturn: Value(expectedAnnualReturn),
      paramsJson: Value(paramsJson),
      createdAt: Value(createdAt),
    );
  }

  factory GoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalRow(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<GoalType>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      targetCents: serializer.fromJson<int>(json['targetCents']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      expectedAnnualReturn: serializer.fromJson<double>(
        json['expectedAnnualReturn'],
      ),
      paramsJson: serializer.fromJson<String>(json['paramsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<GoalType>(type),
      'name': serializer.toJson<String>(name),
      'targetCents': serializer.toJson<int>(targetCents),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'expectedAnnualReturn': serializer.toJson<double>(expectedAnnualReturn),
      'paramsJson': serializer.toJson<String>(paramsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GoalRow copyWith({
    int? id,
    GoalType? type,
    String? name,
    int? targetCents,
    Value<DateTime?> targetDate = const Value.absent(),
    double? expectedAnnualReturn,
    String? paramsJson,
    DateTime? createdAt,
  }) => GoalRow(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name ?? this.name,
    targetCents: targetCents ?? this.targetCents,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    expectedAnnualReturn: expectedAnnualReturn ?? this.expectedAnnualReturn,
    paramsJson: paramsJson ?? this.paramsJson,
    createdAt: createdAt ?? this.createdAt,
  );
  GoalRow copyWithCompanion(GoalsCompanion data) {
    return GoalRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      targetCents: data.targetCents.present
          ? data.targetCents.value
          : this.targetCents,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      expectedAnnualReturn: data.expectedAnnualReturn.present
          ? data.expectedAnnualReturn.value
          : this.expectedAnnualReturn,
      paramsJson: data.paramsJson.present
          ? data.paramsJson.value
          : this.paramsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('targetCents: $targetCents, ')
          ..write('targetDate: $targetDate, ')
          ..write('expectedAnnualReturn: $expectedAnnualReturn, ')
          ..write('paramsJson: $paramsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    name,
    targetCents,
    targetDate,
    expectedAnnualReturn,
    paramsJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.targetCents == this.targetCents &&
          other.targetDate == this.targetDate &&
          other.expectedAnnualReturn == this.expectedAnnualReturn &&
          other.paramsJson == this.paramsJson &&
          other.createdAt == this.createdAt);
}

class GoalsCompanion extends UpdateCompanion<GoalRow> {
  final Value<int> id;
  final Value<GoalType> type;
  final Value<String> name;
  final Value<int> targetCents;
  final Value<DateTime?> targetDate;
  final Value<double> expectedAnnualReturn;
  final Value<String> paramsJson;
  final Value<DateTime> createdAt;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.targetCents = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.expectedAnnualReturn = const Value.absent(),
    this.paramsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required GoalType type,
    required String name,
    required int targetCents,
    this.targetDate = const Value.absent(),
    this.expectedAnnualReturn = const Value.absent(),
    this.paramsJson = const Value.absent(),
    required DateTime createdAt,
  }) : type = Value(type),
       name = Value(name),
       targetCents = Value(targetCents),
       createdAt = Value(createdAt);
  static Insertable<GoalRow> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<int>? targetCents,
    Expression<DateTime>? targetDate,
    Expression<double>? expectedAnnualReturn,
    Expression<String>? paramsJson,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (targetCents != null) 'target_cents': targetCents,
      if (targetDate != null) 'target_date': targetDate,
      if (expectedAnnualReturn != null)
        'expected_annual_return': expectedAnnualReturn,
      if (paramsJson != null) 'params_json': paramsJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GoalsCompanion copyWith({
    Value<int>? id,
    Value<GoalType>? type,
    Value<String>? name,
    Value<int>? targetCents,
    Value<DateTime?>? targetDate,
    Value<double>? expectedAnnualReturn,
    Value<String>? paramsJson,
    Value<DateTime>? createdAt,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      targetCents: targetCents ?? this.targetCents,
      targetDate: targetDate ?? this.targetDate,
      expectedAnnualReturn: expectedAnnualReturn ?? this.expectedAnnualReturn,
      paramsJson: paramsJson ?? this.paramsJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $GoalsTable.$convertertype.toSql(type.value),
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetCents.present) {
      map['target_cents'] = Variable<int>(targetCents.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (expectedAnnualReturn.present) {
      map['expected_annual_return'] = Variable<double>(
        expectedAnnualReturn.value,
      );
    }
    if (paramsJson.present) {
      map['params_json'] = Variable<String>(paramsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('targetCents: $targetCents, ')
          ..write('targetDate: $targetDate, ')
          ..write('expectedAnnualReturn: $expectedAnnualReturn, ')
          ..write('paramsJson: $paramsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AssetsTable extends Assets with TableInfo<$AssetsTable, AssetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AssetCategory, String> category =
      GeneratedColumn<String>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AssetCategory>($AssetsTable.$convertercategory);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    name,
    goalId,
    metadataJson,
    notes,
    createdAt,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: $AssetsTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_id'],
      ),
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $AssetsTable createAlias(String alias) {
    return $AssetsTable(attachedDatabase, alias);
  }

  static TypeConverter<AssetCategory, String> $convertercategory =
      const DbEnumConverter(AssetCategory.values);
}

class AssetRow extends DataClass implements Insertable<AssetRow> {
  final int id;
  final AssetCategory category;
  final String name;
  final int? goalId;
  final String metadataJson;
  final String? notes;
  final DateTime createdAt;
  final bool archived;
  const AssetRow({
    required this.id,
    required this.category,
    required this.name,
    this.goalId,
    required this.metadataJson,
    this.notes,
    required this.createdAt,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['category'] = Variable<String>(
        $AssetsTable.$convertercategory.toSql(category),
      );
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<int>(goalId);
    }
    map['metadata_json'] = Variable<String>(metadataJson);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  AssetsCompanion toCompanion(bool nullToAbsent) {
    return AssetsCompanion(
      id: Value(id),
      category: Value(category),
      name: Value(name),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      metadataJson: Value(metadataJson),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      archived: Value(archived),
    );
  }

  factory AssetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetRow(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<AssetCategory>(json['category']),
      name: serializer.fromJson<String>(json['name']),
      goalId: serializer.fromJson<int?>(json['goalId']),
      metadataJson: serializer.fromJson<String>(json['metadataJson']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<AssetCategory>(category),
      'name': serializer.toJson<String>(name),
      'goalId': serializer.toJson<int?>(goalId),
      'metadataJson': serializer.toJson<String>(metadataJson),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  AssetRow copyWith({
    int? id,
    AssetCategory? category,
    String? name,
    Value<int?> goalId = const Value.absent(),
    String? metadataJson,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    bool? archived,
  }) => AssetRow(
    id: id ?? this.id,
    category: category ?? this.category,
    name: name ?? this.name,
    goalId: goalId.present ? goalId.value : this.goalId,
    metadataJson: metadataJson ?? this.metadataJson,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    archived: archived ?? this.archived,
  );
  AssetRow copyWithCompanion(AssetsCompanion data) {
    return AssetRow(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      name: data.name.present ? data.name.value : this.name,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetRow(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('name: $name, ')
          ..write('goalId: $goalId, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    name,
    goalId,
    metadataJson,
    notes,
    createdAt,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetRow &&
          other.id == this.id &&
          other.category == this.category &&
          other.name == this.name &&
          other.goalId == this.goalId &&
          other.metadataJson == this.metadataJson &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.archived == this.archived);
}

class AssetsCompanion extends UpdateCompanion<AssetRow> {
  final Value<int> id;
  final Value<AssetCategory> category;
  final Value<String> name;
  final Value<int?> goalId;
  final Value<String> metadataJson;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<bool> archived;
  const AssetsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.name = const Value.absent(),
    this.goalId = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.archived = const Value.absent(),
  });
  AssetsCompanion.insert({
    this.id = const Value.absent(),
    required AssetCategory category,
    required String name,
    this.goalId = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.archived = const Value.absent(),
  }) : category = Value(category),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<AssetRow> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? name,
    Expression<int>? goalId,
    Expression<String>? metadataJson,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<bool>? archived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (name != null) 'name': name,
      if (goalId != null) 'goal_id': goalId,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (archived != null) 'archived': archived,
    });
  }

  AssetsCompanion copyWith({
    Value<int>? id,
    Value<AssetCategory>? category,
    Value<String>? name,
    Value<int?>? goalId,
    Value<String>? metadataJson,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<bool>? archived,
  }) {
    return AssetsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      goalId: goalId ?? this.goalId,
      metadataJson: metadataJson ?? this.metadataJson,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      archived: archived ?? this.archived,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $AssetsTable.$convertercategory.toSql(category.value),
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('name: $name, ')
          ..write('goalId: $goalId, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  @override
  late final GeneratedColumn<int> assetId = GeneratedColumn<int>(
    'asset_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES assets (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TransactionType>($TransactionsTable.$convertertype);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Decimal?, String> quantity =
      GeneratedColumn<String>(
        'quantity',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Decimal?>($TransactionsTable.$converterquantityn);
  static const VerificationMeta _feeCentsMeta = const VerificationMeta(
    'feeCents',
  );
  @override
  late final GeneratedColumn<int> feeCents = GeneratedColumn<int>(
    'fee_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    assetId,
    type,
    date,
    amountCents,
    quantity,
    feeCents,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('fee_cents')) {
      context.handle(
        _feeCentsMeta,
        feeCents.isAcceptableOrUnknown(data['fee_cents']!, _feeCentsMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}asset_id'],
      )!,
      type: $TransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      quantity: $TransactionsTable.$converterquantityn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}quantity'],
        ),
      ),
      feeCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fee_cents'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static TypeConverter<TransactionType, String> $convertertype =
      const DbEnumConverter(TransactionType.values);
  static TypeConverter<Decimal, String> $converterquantity =
      const DecimalConverter();
  static TypeConverter<Decimal?, String?> $converterquantityn =
      NullAwareTypeConverter.wrap($converterquantity);
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final int id;
  final int assetId;
  final TransactionType type;
  final DateTime date;
  final int amountCents;
  final Decimal? quantity;
  final int? feeCents;
  final String? note;
  const TransactionRow({
    required this.id,
    required this.assetId,
    required this.type,
    required this.date,
    required this.amountCents,
    this.quantity,
    this.feeCents,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['asset_id'] = Variable<int>(assetId);
    {
      map['type'] = Variable<String>(
        $TransactionsTable.$convertertype.toSql(type),
      );
    }
    map['date'] = Variable<DateTime>(date);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<String>(
        $TransactionsTable.$converterquantityn.toSql(quantity),
      );
    }
    if (!nullToAbsent || feeCents != null) {
      map['fee_cents'] = Variable<int>(feeCents);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      assetId: Value(assetId),
      type: Value(type),
      date: Value(date),
      amountCents: Value(amountCents),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      feeCents: feeCents == null && nullToAbsent
          ? const Value.absent()
          : Value(feeCents),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<int>(json['id']),
      assetId: serializer.fromJson<int>(json['assetId']),
      type: serializer.fromJson<TransactionType>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      quantity: serializer.fromJson<Decimal?>(json['quantity']),
      feeCents: serializer.fromJson<int?>(json['feeCents']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'assetId': serializer.toJson<int>(assetId),
      'type': serializer.toJson<TransactionType>(type),
      'date': serializer.toJson<DateTime>(date),
      'amountCents': serializer.toJson<int>(amountCents),
      'quantity': serializer.toJson<Decimal?>(quantity),
      'feeCents': serializer.toJson<int?>(feeCents),
      'note': serializer.toJson<String?>(note),
    };
  }

  TransactionRow copyWith({
    int? id,
    int? assetId,
    TransactionType? type,
    DateTime? date,
    int? amountCents,
    Value<Decimal?> quantity = const Value.absent(),
    Value<int?> feeCents = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => TransactionRow(
    id: id ?? this.id,
    assetId: assetId ?? this.assetId,
    type: type ?? this.type,
    date: date ?? this.date,
    amountCents: amountCents ?? this.amountCents,
    quantity: quantity.present ? quantity.value : this.quantity,
    feeCents: feeCents.present ? feeCents.value : this.feeCents,
    note: note.present ? note.value : this.note,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      feeCents: data.feeCents.present ? data.feeCents.value : this.feeCents,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('amountCents: $amountCents, ')
          ..write('quantity: $quantity, ')
          ..write('feeCents: $feeCents, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    assetId,
    type,
    date,
    amountCents,
    quantity,
    feeCents,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.assetId == this.assetId &&
          other.type == this.type &&
          other.date == this.date &&
          other.amountCents == this.amountCents &&
          other.quantity == this.quantity &&
          other.feeCents == this.feeCents &&
          other.note == this.note);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<int> id;
  final Value<int> assetId;
  final Value<TransactionType> type;
  final Value<DateTime> date;
  final Value<int> amountCents;
  final Value<Decimal?> quantity;
  final Value<int?> feeCents;
  final Value<String?> note;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.assetId = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.quantity = const Value.absent(),
    this.feeCents = const Value.absent(),
    this.note = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int assetId,
    required TransactionType type,
    required DateTime date,
    required int amountCents,
    this.quantity = const Value.absent(),
    this.feeCents = const Value.absent(),
    this.note = const Value.absent(),
  }) : assetId = Value(assetId),
       type = Value(type),
       date = Value(date),
       amountCents = Value(amountCents);
  static Insertable<TransactionRow> custom({
    Expression<int>? id,
    Expression<int>? assetId,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<int>? amountCents,
    Expression<String>? quantity,
    Expression<int>? feeCents,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetId != null) 'asset_id': assetId,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (amountCents != null) 'amount_cents': amountCents,
      if (quantity != null) 'quantity': quantity,
      if (feeCents != null) 'fee_cents': feeCents,
      if (note != null) 'note': note,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? assetId,
    Value<TransactionType>? type,
    Value<DateTime>? date,
    Value<int>? amountCents,
    Value<Decimal?>? quantity,
    Value<int?>? feeCents,
    Value<String?>? note,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      type: type ?? this.type,
      date: date ?? this.date,
      amountCents: amountCents ?? this.amountCents,
      quantity: quantity ?? this.quantity,
      feeCents: feeCents ?? this.feeCents,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<int>(assetId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<String>(
        $TransactionsTable.$converterquantityn.toSql(quantity.value),
      );
    }
    if (feeCents.present) {
      map['fee_cents'] = Variable<int>(feeCents.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('amountCents: $amountCents, ')
          ..write('quantity: $quantity, ')
          ..write('feeCents: $feeCents, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $LessonProgressTable extends LessonProgress
    with TableInfo<$LessonProgressTable, LessonProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<DateTime> readAt = GeneratedColumn<DateTime>(
    'read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quizPassedAtMeta = const VerificationMeta(
    'quizPassedAt',
  );
  @override
  late final GeneratedColumn<DateTime> quizPassedAt = GeneratedColumn<DateTime>(
    'quiz_passed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [lessonId, readAt, quizPassedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<LessonProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('read_at')) {
      context.handle(
        _readAtMeta,
        readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta),
      );
    }
    if (data.containsKey('quiz_passed_at')) {
      context.handle(
        _quizPassedAtMeta,
        quizPassedAt.isAcceptableOrUnknown(
          data['quiz_passed_at']!,
          _quizPassedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {lessonId};
  @override
  LessonProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonProgressRow(
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_id'],
      )!,
      readAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}read_at'],
      ),
      quizPassedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}quiz_passed_at'],
      ),
    );
  }

  @override
  $LessonProgressTable createAlias(String alias) {
    return $LessonProgressTable(attachedDatabase, alias);
  }
}

class LessonProgressRow extends DataClass
    implements Insertable<LessonProgressRow> {
  final String lessonId;
  final DateTime? readAt;
  final DateTime? quizPassedAt;
  const LessonProgressRow({
    required this.lessonId,
    this.readAt,
    this.quizPassedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['lesson_id'] = Variable<String>(lessonId);
    if (!nullToAbsent || readAt != null) {
      map['read_at'] = Variable<DateTime>(readAt);
    }
    if (!nullToAbsent || quizPassedAt != null) {
      map['quiz_passed_at'] = Variable<DateTime>(quizPassedAt);
    }
    return map;
  }

  LessonProgressCompanion toCompanion(bool nullToAbsent) {
    return LessonProgressCompanion(
      lessonId: Value(lessonId),
      readAt: readAt == null && nullToAbsent
          ? const Value.absent()
          : Value(readAt),
      quizPassedAt: quizPassedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(quizPassedAt),
    );
  }

  factory LessonProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonProgressRow(
      lessonId: serializer.fromJson<String>(json['lessonId']),
      readAt: serializer.fromJson<DateTime?>(json['readAt']),
      quizPassedAt: serializer.fromJson<DateTime?>(json['quizPassedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lessonId': serializer.toJson<String>(lessonId),
      'readAt': serializer.toJson<DateTime?>(readAt),
      'quizPassedAt': serializer.toJson<DateTime?>(quizPassedAt),
    };
  }

  LessonProgressRow copyWith({
    String? lessonId,
    Value<DateTime?> readAt = const Value.absent(),
    Value<DateTime?> quizPassedAt = const Value.absent(),
  }) => LessonProgressRow(
    lessonId: lessonId ?? this.lessonId,
    readAt: readAt.present ? readAt.value : this.readAt,
    quizPassedAt: quizPassedAt.present ? quizPassedAt.value : this.quizPassedAt,
  );
  LessonProgressRow copyWithCompanion(LessonProgressCompanion data) {
    return LessonProgressRow(
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      readAt: data.readAt.present ? data.readAt.value : this.readAt,
      quizPassedAt: data.quizPassedAt.present
          ? data.quizPassedAt.value
          : this.quizPassedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressRow(')
          ..write('lessonId: $lessonId, ')
          ..write('readAt: $readAt, ')
          ..write('quizPassedAt: $quizPassedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(lessonId, readAt, quizPassedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonProgressRow &&
          other.lessonId == this.lessonId &&
          other.readAt == this.readAt &&
          other.quizPassedAt == this.quizPassedAt);
}

class LessonProgressCompanion extends UpdateCompanion<LessonProgressRow> {
  final Value<String> lessonId;
  final Value<DateTime?> readAt;
  final Value<DateTime?> quizPassedAt;
  final Value<int> rowid;
  const LessonProgressCompanion({
    this.lessonId = const Value.absent(),
    this.readAt = const Value.absent(),
    this.quizPassedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LessonProgressCompanion.insert({
    required String lessonId,
    this.readAt = const Value.absent(),
    this.quizPassedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : lessonId = Value(lessonId);
  static Insertable<LessonProgressRow> custom({
    Expression<String>? lessonId,
    Expression<DateTime>? readAt,
    Expression<DateTime>? quizPassedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lessonId != null) 'lesson_id': lessonId,
      if (readAt != null) 'read_at': readAt,
      if (quizPassedAt != null) 'quiz_passed_at': quizPassedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LessonProgressCompanion copyWith({
    Value<String>? lessonId,
    Value<DateTime?>? readAt,
    Value<DateTime?>? quizPassedAt,
    Value<int>? rowid,
  }) {
    return LessonProgressCompanion(
      lessonId: lessonId ?? this.lessonId,
      readAt: readAt ?? this.readAt,
      quizPassedAt: quizPassedAt ?? this.quizPassedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<DateTime>(readAt.value);
    }
    if (quizPassedAt.present) {
      map['quiz_passed_at'] = Variable<DateTime>(quizPassedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressCompanion(')
          ..write('lessonId: $lessonId, ')
          ..write('readAt: $readAt, ')
          ..write('quizPassedAt: $quizPassedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $MonthlyExpensesTable monthlyExpenses = $MonthlyExpensesTable(
    this,
  );
  late final $GoalsTable goals = $GoalsTable(this);
  late final $AssetsTable assets = $AssetsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $LessonProgressTable lessonProgress = $LessonProgressTable(this);
  late final ProfileDao profileDao = ProfileDao(this as AppDatabase);
  late final GoalsDao goalsDao = GoalsDao(this as AppDatabase);
  late final InvestmentsDao investmentsDao = InvestmentsDao(
    this as AppDatabase,
  );
  late final LessonProgressDao lessonProgressDao = LessonProgressDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    monthlyExpenses,
    goals,
    assets,
    transactions,
    lessonProgress,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('assets', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      required AgeRange ageRange,
      required Employment employment,
      Value<int?> monthlyIncomeCents,
      required bool hasDependents,
      required bool hasHighInterestDebt,
      Value<int?> debtCents,
      required int riskScore,
      required RiskProfile riskProfile,
      required KnowledgeLevel knowledgeLevel,
      required int emergencyMonths,
      required String locale,
      Value<DateTime?> onboardingCompletedAt,
      Value<AppThemeMode> themeMode,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<AgeRange> ageRange,
      Value<Employment> employment,
      Value<int?> monthlyIncomeCents,
      Value<bool> hasDependents,
      Value<bool> hasHighInterestDebt,
      Value<int?> debtCents,
      Value<int> riskScore,
      Value<RiskProfile> riskProfile,
      Value<KnowledgeLevel> knowledgeLevel,
      Value<int> emergencyMonths,
      Value<String> locale,
      Value<DateTime?> onboardingCompletedAt,
      Value<AppThemeMode> themeMode,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AgeRange, AgeRange, String> get ageRange =>
      $composableBuilder(
        column: $table.ageRange,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Employment, Employment, String>
  get employment => $composableBuilder(
    column: $table.employment,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get monthlyIncomeCents => $composableBuilder(
    column: $table.monthlyIncomeCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasDependents => $composableBuilder(
    column: $table.hasDependents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasHighInterestDebt => $composableBuilder(
    column: $table.hasHighInterestDebt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get debtCents => $composableBuilder(
    column: $table.debtCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RiskProfile, RiskProfile, String>
  get riskProfile => $composableBuilder(
    column: $table.riskProfile,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<KnowledgeLevel, KnowledgeLevel, String>
  get knowledgeLevel => $composableBuilder(
    column: $table.knowledgeLevel,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get emergencyMonths => $composableBuilder(
    column: $table.emergencyMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get onboardingCompletedAt => $composableBuilder(
    column: $table.onboardingCompletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AppThemeMode, AppThemeMode, String>
  get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ageRange => $composableBuilder(
    column: $table.ageRange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employment => $composableBuilder(
    column: $table.employment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyIncomeCents => $composableBuilder(
    column: $table.monthlyIncomeCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasDependents => $composableBuilder(
    column: $table.hasDependents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasHighInterestDebt => $composableBuilder(
    column: $table.hasHighInterestDebt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get debtCents => $composableBuilder(
    column: $table.debtCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskProfile => $composableBuilder(
    column: $table.riskProfile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get knowledgeLevel => $composableBuilder(
    column: $table.knowledgeLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get emergencyMonths => $composableBuilder(
    column: $table.emergencyMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get onboardingCompletedAt => $composableBuilder(
    column: $table.onboardingCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AgeRange, String> get ageRange =>
      $composableBuilder(column: $table.ageRange, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Employment, String> get employment =>
      $composableBuilder(
        column: $table.employment,
        builder: (column) => column,
      );

  GeneratedColumn<int> get monthlyIncomeCents => $composableBuilder(
    column: $table.monthlyIncomeCents,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasDependents => $composableBuilder(
    column: $table.hasDependents,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasHighInterestDebt => $composableBuilder(
    column: $table.hasHighInterestDebt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get debtCents =>
      $composableBuilder(column: $table.debtCents, builder: (column) => column);

  GeneratedColumn<int> get riskScore =>
      $composableBuilder(column: $table.riskScore, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RiskProfile, String> get riskProfile =>
      $composableBuilder(
        column: $table.riskProfile,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<KnowledgeLevel, String> get knowledgeLevel =>
      $composableBuilder(
        column: $table.knowledgeLevel,
        builder: (column) => column,
      );

  GeneratedColumn<int> get emergencyMonths => $composableBuilder(
    column: $table.emergencyMonths,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<DateTime> get onboardingCompletedAt => $composableBuilder(
    column: $table.onboardingCompletedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AppThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfileRow,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfileRow,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow>,
          ),
          UserProfileRow,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<AgeRange> ageRange = const Value.absent(),
                Value<Employment> employment = const Value.absent(),
                Value<int?> monthlyIncomeCents = const Value.absent(),
                Value<bool> hasDependents = const Value.absent(),
                Value<bool> hasHighInterestDebt = const Value.absent(),
                Value<int?> debtCents = const Value.absent(),
                Value<int> riskScore = const Value.absent(),
                Value<RiskProfile> riskProfile = const Value.absent(),
                Value<KnowledgeLevel> knowledgeLevel = const Value.absent(),
                Value<int> emergencyMonths = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<DateTime?> onboardingCompletedAt = const Value.absent(),
                Value<AppThemeMode> themeMode = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                ageRange: ageRange,
                employment: employment,
                monthlyIncomeCents: monthlyIncomeCents,
                hasDependents: hasDependents,
                hasHighInterestDebt: hasHighInterestDebt,
                debtCents: debtCents,
                riskScore: riskScore,
                riskProfile: riskProfile,
                knowledgeLevel: knowledgeLevel,
                emergencyMonths: emergencyMonths,
                locale: locale,
                onboardingCompletedAt: onboardingCompletedAt,
                themeMode: themeMode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required AgeRange ageRange,
                required Employment employment,
                Value<int?> monthlyIncomeCents = const Value.absent(),
                required bool hasDependents,
                required bool hasHighInterestDebt,
                Value<int?> debtCents = const Value.absent(),
                required int riskScore,
                required RiskProfile riskProfile,
                required KnowledgeLevel knowledgeLevel,
                required int emergencyMonths,
                required String locale,
                Value<DateTime?> onboardingCompletedAt = const Value.absent(),
                Value<AppThemeMode> themeMode = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                ageRange: ageRange,
                employment: employment,
                monthlyIncomeCents: monthlyIncomeCents,
                hasDependents: hasDependents,
                hasHighInterestDebt: hasHighInterestDebt,
                debtCents: debtCents,
                riskScore: riskScore,
                riskProfile: riskProfile,
                knowledgeLevel: knowledgeLevel,
                emergencyMonths: emergencyMonths,
                locale: locale,
                onboardingCompletedAt: onboardingCompletedAt,
                themeMode: themeMode,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserProfilesTable, UserProfileRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserProfilesTable,
                    UserProfileRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfileRow,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfileRow,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow>,
      ),
      UserProfileRow,
      PrefetchHooks Function()
    >;
typedef $$MonthlyExpensesTableCreateCompanionBuilder =
    MonthlyExpensesCompanion Function({
      Value<int> id,
      required ExpenseCategory category,
      required int amountCents,
    });
typedef $$MonthlyExpensesTableUpdateCompanionBuilder =
    MonthlyExpensesCompanion Function({
      Value<int> id,
      Value<ExpenseCategory> category,
      Value<int> amountCents,
    });

class $$MonthlyExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyExpensesTable> {
  $$MonthlyExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ExpenseCategory, ExpenseCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MonthlyExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyExpensesTable> {
  $$MonthlyExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MonthlyExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyExpensesTable> {
  $$MonthlyExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExpenseCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );
}

class $$MonthlyExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyExpensesTable,
          MonthlyExpenseRow,
          $$MonthlyExpensesTableFilterComposer,
          $$MonthlyExpensesTableOrderingComposer,
          $$MonthlyExpensesTableAnnotationComposer,
          $$MonthlyExpensesTableCreateCompanionBuilder,
          $$MonthlyExpensesTableUpdateCompanionBuilder,
          (
            MonthlyExpenseRow,
            BaseReferences<
              _$AppDatabase,
              $MonthlyExpensesTable,
              MonthlyExpenseRow
            >,
          ),
          MonthlyExpenseRow,
          PrefetchHooks Function()
        > {
  $$MonthlyExpensesTableTableManager(
    _$AppDatabase db,
    $MonthlyExpensesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<ExpenseCategory> category = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
              }) => MonthlyExpensesCompanion(
                id: id,
                category: category,
                amountCents: amountCents,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required ExpenseCategory category,
                required int amountCents,
              }) => MonthlyExpensesCompanion.insert(
                id: id,
                category: category,
                amountCents: amountCents,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MonthlyExpensesTable, MonthlyExpenseRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MonthlyExpensesTable,
                    MonthlyExpenseRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MonthlyExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyExpensesTable,
      MonthlyExpenseRow,
      $$MonthlyExpensesTableFilterComposer,
      $$MonthlyExpensesTableOrderingComposer,
      $$MonthlyExpensesTableAnnotationComposer,
      $$MonthlyExpensesTableCreateCompanionBuilder,
      $$MonthlyExpensesTableUpdateCompanionBuilder,
      (
        MonthlyExpenseRow,
        BaseReferences<_$AppDatabase, $MonthlyExpensesTable, MonthlyExpenseRow>,
      ),
      MonthlyExpenseRow,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  required GoalType type,
  required String name,
  required int targetCents,
  Value<DateTime?> targetDate,
  Value<double> expectedAnnualReturn,
  Value<String> paramsJson,
  required DateTime createdAt,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  Value<GoalType> type,
  Value<String> name,
  Value<int> targetCents,
  Value<DateTime?> targetDate,
  Value<double> expectedAnnualReturn,
  Value<String> paramsJson,
  Value<DateTime> createdAt,
});

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, GoalRow> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AssetsTable, List<AssetRow>> _assetsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.assets,
    aliasName: 'goals__id__assets__goal_id',
  );

  $$AssetsTableProcessedTableManager get assetsRefs {
    final manager = $$AssetsTableTableManager(
      $_db,
      $_db.assets,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_assetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalType, GoalType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedAnnualReturn => $composableBuilder(
    column: $table.expectedAnnualReturn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paramsJson => $composableBuilder(
    column: $table.paramsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> assetsRefs(
    Expression<bool> Function($$AssetsTableFilterComposer f) f,
  ) {
    final $$AssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableFilterComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedAnnualReturn => $composableBuilder(
    column: $table.expectedAnnualReturn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paramsJson => $composableBuilder(
    column: $table.paramsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get expectedAnnualReturn => $composableBuilder(
    column: $table.expectedAnnualReturn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paramsJson => $composableBuilder(
    column: $table.paramsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> assetsRefs<T extends Object>(
    Expression<T> Function($$AssetsTableAnnotationComposer a) f,
  ) {
    final $$AssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          GoalRow,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (GoalRow, $$GoalsTableReferences),
          GoalRow,
          PrefetchHooks Function({bool assetsRefs})
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<GoalType> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> targetCents = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<double> expectedAnnualReturn = const Value.absent(),
                Value<String> paramsJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                type: type,
                name: name,
                targetCents: targetCents,
                targetDate: targetDate,
                expectedAnnualReturn: expectedAnnualReturn,
                paramsJson: paramsJson,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required GoalType type,
                required String name,
                required int targetCents,
                Value<DateTime?> targetDate = const Value.absent(),
                Value<double> expectedAnnualReturn = const Value.absent(),
                Value<String> paramsJson = const Value.absent(),
                required DateTime createdAt,
              }) => GoalsCompanion.insert(
                id: id,
                type: type,
                name: name,
                targetCents: targetCents,
                targetDate: targetDate,
                expectedAnnualReturn: expectedAnnualReturn,
                paramsJson: paramsJson,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalsTable, GoalRow>(table),
                  $$GoalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({assetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (assetsRefs) db.assets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (assetsRefs)
                    await $_getPrefetchedDataByColumns<
                      GoalRow,
                      $GoalsTable,
                      AssetRow,
                      $AssetsTable
                    >(
                      currentTable: table,
                      referencedTable: $$GoalsTableReferences._assetsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$GoalsTableReferences(db, table, p0).assetsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'goal_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      GoalRow,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (GoalRow, $$GoalsTableReferences),
      GoalRow,
      PrefetchHooks Function({bool assetsRefs})
    >;
typedef $$AssetsTableCreateCompanionBuilder = AssetsCompanion Function({
  Value<int> id,
  required AssetCategory category,
  required String name,
  Value<int?> goalId,
  Value<String> metadataJson,
  Value<String?> notes,
  required DateTime createdAt,
  Value<bool> archived,
});
typedef $$AssetsTableUpdateCompanionBuilder = AssetsCompanion Function({
  Value<int> id,
  Value<AssetCategory> category,
  Value<String> name,
  Value<int?> goalId,
  Value<String> metadataJson,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<bool> archived,
});

final class $$AssetsTableReferences
    extends BaseReferences<_$AppDatabase, $AssetsTable, AssetRow> {
  $$AssetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('assets__goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<int>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransactionsTable, List<TransactionRow>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'assets__id__transactions__asset_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.assetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AssetsTableFilterComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AssetCategory, AssetCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.assetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AssetCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.assetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssetsTable,
          AssetRow,
          $$AssetsTableFilterComposer,
          $$AssetsTableOrderingComposer,
          $$AssetsTableAnnotationComposer,
          $$AssetsTableCreateCompanionBuilder,
          $$AssetsTableUpdateCompanionBuilder,
          (AssetRow, $$AssetsTableReferences),
          AssetRow,
          PrefetchHooks Function({bool goalId, bool transactionsRefs})
        > {
  $$AssetsTableTableManager(_$AppDatabase db, $AssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<AssetCategory> category = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> goalId = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> archived = const Value.absent(),
              }) => AssetsCompanion(
                id: id,
                category: category,
                name: name,
                goalId: goalId,
                metadataJson: metadataJson,
                notes: notes,
                createdAt: createdAt,
                archived: archived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required AssetCategory category,
                required String name,
                Value<int?> goalId = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<bool> archived = const Value.absent(),
              }) => AssetsCompanion.insert(
                id: id,
                category: category,
                name: name,
                goalId: goalId,
                metadataJson: metadataJson,
                notes: notes,
                createdAt: createdAt,
                archived: archived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AssetsTable, AssetRow>(table),
                  $$AssetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false, transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$AssetsTableReferences._goalIdTable(
                          db,
                        ),
                        referencedColumn: $$AssetsTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedDataByColumns<
                      AssetRow,
                      $AssetsTable,
                      TransactionRow,
                      $TransactionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$AssetsTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$AssetsTableReferences(
                        db,
                        table,
                        p0,
                      ).transactionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'asset_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssetsTable,
      AssetRow,
      $$AssetsTableFilterComposer,
      $$AssetsTableOrderingComposer,
      $$AssetsTableAnnotationComposer,
      $$AssetsTableCreateCompanionBuilder,
      $$AssetsTableUpdateCompanionBuilder,
      (AssetRow, $$AssetsTableReferences),
      AssetRow,
      PrefetchHooks Function({bool goalId, bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required int assetId,
      required TransactionType type,
      required DateTime date,
      required int amountCents,
      Value<Decimal?> quantity,
      Value<int?> feeCents,
      Value<String?> note,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<int> assetId,
      Value<TransactionType> type,
      Value<DateTime> date,
      Value<int> amountCents,
      Value<Decimal?> quantity,
      Value<int?> feeCents,
      Value<String?> note,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AssetsTable _assetIdTable(_$AppDatabase db) =>
      db.assets.createAlias('transactions__asset_id__assets__id');

  $$AssetsTableProcessedTableManager get assetId {
    final $_column = $_itemColumn<int>('asset_id')!;

    final manager = $$AssetsTableTableManager(
      $_db,
      $_db.assets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionType, TransactionType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Decimal?, Decimal, String> get quantity =>
      $composableBuilder(
        column: $table.quantity,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get feeCents => $composableBuilder(
    column: $table.feeCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$AssetsTableFilterComposer get assetId {
    final $$AssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableFilterComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get feeCents => $composableBuilder(
    column: $table.feeCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$AssetsTableOrderingComposer get assetId {
    final $$AssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableOrderingComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Decimal?, String> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get feeCents =>
      $composableBuilder(column: $table.feeCents, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$AssetsTableAnnotationComposer get assetId {
    final $$AssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          TransactionRow,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (TransactionRow, $$TransactionsTableReferences),
          TransactionRow,
          PrefetchHooks Function({bool assetId})
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> assetId = const Value.absent(),
                Value<TransactionType> type = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<Decimal?> quantity = const Value.absent(),
                Value<int?> feeCents = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                assetId: assetId,
                type: type,
                date: date,
                amountCents: amountCents,
                quantity: quantity,
                feeCents: feeCents,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int assetId,
                required TransactionType type,
                required DateTime date,
                required int amountCents,
                Value<Decimal?> quantity = const Value.absent(),
                Value<int?> feeCents = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                assetId: assetId,
                type: type,
                date: date,
                amountCents: amountCents,
                quantity: quantity,
                feeCents: feeCents,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, TransactionRow>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({assetId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (assetId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.assetId,
                        referencedTable: $$TransactionsTableReferences
                            ._assetIdTable(db),
                        referencedColumn: $$TransactionsTableReferences
                            ._assetIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      TransactionRow,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (TransactionRow, $$TransactionsTableReferences),
      TransactionRow,
      PrefetchHooks Function({bool assetId})
    >;
typedef $$LessonProgressTableCreateCompanionBuilder =
    LessonProgressCompanion Function({
      required String lessonId,
      Value<DateTime?> readAt,
      Value<DateTime?> quizPassedAt,
      Value<int> rowid,
    });
typedef $$LessonProgressTableUpdateCompanionBuilder =
    LessonProgressCompanion Function({
      Value<String> lessonId,
      Value<DateTime?> readAt,
      Value<DateTime?> quizPassedAt,
      Value<int> rowid,
    });

class $$LessonProgressTableFilterComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get quizPassedAt => $composableBuilder(
    column: $table.quizPassedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LessonProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get quizPassedAt => $composableBuilder(
    column: $table.quizPassedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LessonProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<DateTime> get readAt =>
      $composableBuilder(column: $table.readAt, builder: (column) => column);

  GeneratedColumn<DateTime> get quizPassedAt => $composableBuilder(
    column: $table.quizPassedAt,
    builder: (column) => column,
  );
}

class $$LessonProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LessonProgressTable,
          LessonProgressRow,
          $$LessonProgressTableFilterComposer,
          $$LessonProgressTableOrderingComposer,
          $$LessonProgressTableAnnotationComposer,
          $$LessonProgressTableCreateCompanionBuilder,
          $$LessonProgressTableUpdateCompanionBuilder,
          (
            LessonProgressRow,
            BaseReferences<
              _$AppDatabase,
              $LessonProgressTable,
              LessonProgressRow
            >,
          ),
          LessonProgressRow,
          PrefetchHooks Function()
        > {
  $$LessonProgressTableTableManager(
    _$AppDatabase db,
    $LessonProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> lessonId = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                Value<DateTime?> quizPassedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LessonProgressCompanion(
                lessonId: lessonId,
                readAt: readAt,
                quizPassedAt: quizPassedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String lessonId,
                Value<DateTime?> readAt = const Value.absent(),
                Value<DateTime?> quizPassedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LessonProgressCompanion.insert(
                lessonId: lessonId,
                readAt: readAt,
                quizPassedAt: quizPassedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LessonProgressTable, LessonProgressRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LessonProgressTable,
                    LessonProgressRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LessonProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LessonProgressTable,
      LessonProgressRow,
      $$LessonProgressTableFilterComposer,
      $$LessonProgressTableOrderingComposer,
      $$LessonProgressTableAnnotationComposer,
      $$LessonProgressTableCreateCompanionBuilder,
      $$LessonProgressTableUpdateCompanionBuilder,
      (
        LessonProgressRow,
        BaseReferences<_$AppDatabase, $LessonProgressTable, LessonProgressRow>,
      ),
      LessonProgressRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$MonthlyExpensesTableTableManager get monthlyExpenses =>
      $$MonthlyExpensesTableTableManager(_db, _db.monthlyExpenses);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$AssetsTableTableManager get assets =>
      $$AssetsTableTableManager(_db, _db.assets);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$LessonProgressTableTableManager get lessonProgress =>
      $$LessonProgressTableTableManager(_db, _db.lessonProgress);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';
