import 'package:dio/dio.dart';
import 'package:grocery_store_app/helper/dio_client.dart';
import 'package:grocery_store_app/models/user_model.dart';
import 'package:grocery_store_app/services/storage_service.dart';

class UserService {
  Future<UserModel?> getUser() async {
    String? token = await StorageService.getToken();

    try {
      final Response response = await DioClient.instance.get(
        '/user',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.data != null && response.data['data'] != null) {
        return UserModel.fromJson(response.data['data']);
      } else {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> updateUser({
    required String name,
    String? password,
  }) async {
    String? token = await StorageService.getToken();

    try {
      Map<String, dynamic> data = {'name': name};
      if (password != null && password.isNotEmpty) {
        data['password'] = password;
      }

      final Response response = await DioClient.instance.post(
        '/user/update',
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        final Map<String, dynamic> errorData = e.response!.data;

        if (errorData.containsKey('errors')) {
          String errorMessage = errorData['errors']
              .values
              .map((messages) => messages.join(', '))
              .join('\n');
          throw Exception(errorMessage);
        } else if (errorData.containsKey('message')) {
          throw Exception(errorData['messages']);
        }
      }
      throw Exception('Failed to update user');
    }
  }
}
