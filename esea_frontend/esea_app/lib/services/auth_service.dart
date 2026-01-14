import 'package:dio/dio.dart';

import '../models/user.dart';
import '../constants/api_constants.dart';
import 'dio_client.dart';
import 'storage_service.dart';

class AuthService {
  final Dio _dio = DioClient().dio;
  final StorageService _storage = StorageService();

  /// STEP 1: Get SSO redirect URL
  Future<String?> getSSOLoginUrl() async {
    final res = await _dio.get(ApiConstants.ssoLogin);
    return res.data['url'];
  }

  /// STEP 2: Fetch current user (AUTH REQUIRED)
  Future<User?> fetchCurrentUser() async {
  final token = await _storage.getToken();
  if (token == null) return null;

  try {
    final res = await _dio.get(
      ApiConstants.me,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final user = User.fromJson(res.data);
    await _storage.saveUser(user);
    return user;
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      // 🔥 Token invalid → logout cleanly
      await _storage.clearAll();
      return null;
    }
    rethrow; // real errors still bubble up
  }
}


  /// SAVE TOKEN
  Future<void> saveToken(String token) async {
    await _storage.saveToken(token);
  }

  /// RESTORE TOKEN
  Future<String?> getSavedToken() async {
    return await _storage.getToken();
  }

  /// LOGOUT
  Future<void> logout() async {
    await _storage.clearAll();
  }
}
