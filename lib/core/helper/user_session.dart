import 'dart:developer';

import 'package:icd_teacher/core/constant/shared_preferences_key.dart';

import 'shaerd_pref_helper.dart';

// class UserSession {
//   static Future<bool> isLoggedIn() async {
//     final token = await SharedPrefHelper.getSecuredString(
//       SharedPreferencesKeys.accessToken,
//     );
//     return token != null && token.isNotEmpty;
//   }

//   static Future<void> logout() async {
//     await SharedPrefHelper.clearAllSecuredData();
//   }

// }
// In user_session.dart
class UserSession {
  static Future<bool> isLoggedIn() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPreferencesKeys.accessToken,
    );
    return token != null && token.isNotEmpty;
  }

  static Future<void> logout() async {
    // Clear all secure storage
    await SharedPrefHelper.clearAllSecuredData();

    // Optional: Clear regular SharedPreferences too
    await SharedPrefHelper.clearAllData();

    // Log for debugging
    log('User logged out successfully');
  }

  // New method to verify logout
  static Future<bool> verifyLogout() async {
    final accessToken = await SharedPrefHelper.getSecuredString(
      SharedPreferencesKeys.accessToken,
    );
    final refreshToken = await SharedPrefHelper.getSecuredString(
      SharedPreferencesKeys.refreshToken,
    );

    return accessToken.isEmpty && refreshToken.isEmpty;
  }
}
