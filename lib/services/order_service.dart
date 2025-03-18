import 'package:dio/dio.dart';
import 'package:grocery_store_app/constants/constants.dart';
import 'package:grocery_store_app/model/order_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/checkout_model.dart';
import 'storage_service.dart';

class OrderService {
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

  Future<List<OrderModel>> fetchOrder() async {
    String? token = await StorageService.getToken();
    try {
      Response response = await dio.get('/orders',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }));
      if (response.statusCode == 200) {
        List data = response.data['data']['data'];
        return data.map((json) => OrderModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil data order');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  Future<CheckoutModel?> checkoutOrder(double totalPrice) async {
    String? token = await StorageService.getToken();

    try {
      Response response = await dio.post(
        '/orders',
        data: {
          'total_price': totalPrice,
        },
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
