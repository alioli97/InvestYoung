// Learn content described by `assets/learn/index.json` (docs/SPEC.md §7).

/// Text in every supported language.
class LocalizedText {
  const LocalizedText(this.values);

  factory LocalizedText.fromJson(Map<String, dynamic> json) =>
      LocalizedText(json.cast<String, String>());

  final Map<String, String> values;

  /// Text in [languageCode], falling back to Spanish.
  String of(String languageCode) => values[languageCode] ?? values['es'] ?? '';
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
    question: LocalizedText.fromJson(json['question'] as Map<String, dynamic>),
    options: [
      for (final o in json['options'] as List)
        LocalizedText.fromJson(o as Map<String, dynamic>),
    ],
    answer: json['answer'] as int,
  );

  final LocalizedText question;
  final List<LocalizedText> options;

  /// Index of the correct option.
  final int answer;
}

class LessonInfo {
  const LessonInfo({
    required this.id,
    required this.moduleId,
    required this.file,
    required this.minutes,
    required this.title,
    required this.quiz,
  });

  factory LessonInfo.fromJson(String moduleId, Map<String, dynamic> json) =>
      LessonInfo(
        id: json['id'] as String,
        moduleId: moduleId,
        file: json['file'] as String,
        minutes: json['minutes'] as int,
        title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
        quiz: [
          for (final q in json['quiz'] as List? ?? const [])
            QuizQuestion.fromJson(q as Map<String, dynamic>),
        ],
      );

  final String id;
  final String moduleId;

  /// Markdown file name inside `assets/learn/{languageCode}/`.
  final String file;

  /// Estimated reading time.
  final int minutes;
  final LocalizedText title;
  final List<QuizQuestion> quiz;

  String assetPath(String languageCode) => 'assets/learn/$languageCode/$file';
}

class ModuleInfo {
  const ModuleInfo({required this.id, required this.lessons});

  factory ModuleInfo.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    return ModuleInfo(
      id: id,
      lessons: [
        for (final l in json['lessons'] as List)
          LessonInfo.fromJson(id, l as Map<String, dynamic>),
      ],
    );
  }

  /// Matches `LearnModule.id`.
  final String id;
  final List<LessonInfo> lessons;
}

class LearnIndex {
  const LearnIndex(this.modules);

  factory LearnIndex.fromJson(Map<String, dynamic> json) => LearnIndex([
    for (final m in json['modules'] as List)
      ModuleInfo.fromJson(m as Map<String, dynamic>),
  ]);

  final List<ModuleInfo> modules;

  Iterable<LessonInfo> get lessons => modules.expand((m) => m.lessons);

  LessonInfo? lesson(String id) => lessons.where((l) => l.id == id).firstOrNull;
}
