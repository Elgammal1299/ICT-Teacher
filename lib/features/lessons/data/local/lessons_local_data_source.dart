import 'dart:convert';

import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessonsLocalDataSource {
  LessonsLocalDataSource(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static const _lessonsKeyPrefix = 'cached_lessons_';

  Future<List<LessonsModel>?> getLessons(
    String termId,
    String contentType,
  ) async {
    final cachedJson = _sharedPreferences.getString(
      _cacheKey(termId, contentType),
    );
    if (cachedJson == null || cachedJson.isEmpty) return null;

    try {
      final decoded = jsonDecode(cachedJson);
      if (decoded is! List) return null;

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(LessonsModel.fromJson)
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLessons(
    String termId,
    String contentType,
    List<LessonsModel> lessons,
  ) async {
    await _sharedPreferences.setString(
      _cacheKey(termId, contentType),
      jsonEncode(lessons.map((lesson) => lesson.toJson()).toList()),
    );
  }

  String _cacheKey(String termId, String contentType) {
    return '$_lessonsKeyPrefix${termId}_$contentType';
  }
}
