import 'package:dio/dio.dart';
import 'package:grocery_store_app/constants/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static Dio createDio() {
    final options = BaseOptions(
      baseUrl: '$baseURL/api',
      followRedirects: false,
    );

    var dio = Dio(options);

    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        maxWidth: 134,
      ),
    );

    return dio;
  }

  static final Dio instance = createDio();
}
