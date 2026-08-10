import 'dart:convert';

import 'package:icd_teacher/features/home/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  UserLocalDataSource(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static const _userKey = 'cached_user_data';

  /// جلب بيانات المستخدم المحفوظة محلياً
  Future<UserModel?> getUser() async {
    final cachedJson = _sharedPreferences.getString(_userKey);
    if (cachedJson == null || cachedJson.isEmpty) return null;

    try {
      final decoded = jsonDecode(cachedJson);
      if (decoded is! Map<String, dynamic>) return null;
      return UserModel.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  /// حفظ بيانات المستخدم محلياً
  Future<void> saveUser(UserModel user) async {
    await _sharedPreferences.setString(
      _userKey,
      jsonEncode(user.toJson()),
    );
  }
}
