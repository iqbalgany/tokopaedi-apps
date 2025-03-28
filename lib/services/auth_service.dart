import 'package:dio/dio.dart';
import 'package:grocery_store_app/helper/dio_client.dart';
import 'package:grocery_store_app/services/storage_service.dart';

class AuthService {
  Future<Response?> signupService({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await DioClient.instance.post(
        '/register',
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),
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
      Response response = await DioClient.instance.post(
        '/login',
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
        data: {
          'email': email,
          'password': password,
        },
      );

      String? token = response.data['data']['access_token'];

      await StorageService.saveToken(token!);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signoutService() async {
    String? token = await StorageService.getToken();

    try {
      Response response = await DioClient.instance.post(
        '/logout',
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        await StorageService.removeToken();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
