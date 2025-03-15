import 'package:dio/dio.dart';
import 'package:grocery_store_app/services/storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/constants.dart';

class AuthService {
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: '$baseURL/api',
      followRedirects: false,
    );

    var dio = Dio(options);

    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      maxWidth: 134,
    ));

    return dio;
  }

  Dio get dio => _dio();

  Future<Response?> signupService({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> signinService({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      String token = response.data['data']['access_token'];

      await StorageService.saveToken(token);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
