import 'package:dio/dio.dart';
import 'package:grocery_store_app/constants.dart';
import 'package:grocery_store_app/model/user_model.dart';
import 'package:grocery_store_app/services/storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class UserService {
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

  Future<UserModel?> getUser() async {
    String? token = await StorageService.getToken();

    if (token == null) {
      print("Error: Token is null!");
      return null;
    }

    try {
      final Response response = await dio.get(
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
}
