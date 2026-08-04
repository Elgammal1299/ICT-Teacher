import 'dart:convert';

import 'package:icd_teacher/features/home/data/models/content_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentLocalDataSource {
  ContentLocalDataSource(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static const _contentKeyPrefix = 'cached_content_';

  Future<ContentModel?> getContentById(String id) async {
    final cachedJson = _sharedPreferences.getString(_cacheKey(id));
    if (cachedJson == null || cachedJson.isEmpty) return null;

    try {
      final decoded = jsonDecode(cachedJson);
      if (decoded is! Map<String, dynamic>) return null;

      return ContentModel.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveContent(ContentModel content) async {
    await _sharedPreferences.setString(
      _cacheKey(content.id),
      jsonEncode(content.toJson()),
    );
  }

  String _cacheKey(String id) => '$_contentKeyPrefix$id';
}
