import 'package:dio/dio.dart';
import 'package:grocery_store_app/constants/constants.dart';
import 'package:grocery_store_app/model/checkout_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'storage_service.dart';

class CheckoutService {
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

  Future<CheckoutModel?> checkoutOrder() async {
    String? token = await StorageService.getToken();

    try {
      Response response = await dio.post(
        '/orders',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      return CheckoutModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
