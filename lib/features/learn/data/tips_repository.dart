import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/tip.dart';

part 'tips_repository.g.dart';

/// Loads tips from `assets/learn/{languageCode}/tips.json`.
class TipsRepository {
  const TipsRepository(this._bundle);

  final AssetBundle _bundle;

  Future<List<Tip>> load(String languageCode) async {
    final json = await _bundle.loadString(
      'assets/learn/$languageCode/tips.json',
      cache: false, // See LearnRepository.
    );
    final data = jsonDecode(json) as Map<String, dynamic>;
    return [
      for (final item in data['tips'] as List)
        Tip(id: item['id'] as String, text: item['text'] as String),
    ];
  }
}

@Riverpod(keepAlive: true)
TipsRepository tipsRepository(Ref ref) => TipsRepository(rootBundle);

/// Tips in the given language.
@riverpod
Future<List<Tip>> tips(Ref ref, String languageCode) =>
    ref.watch(tipsRepositoryProvider).load(languageCode);
