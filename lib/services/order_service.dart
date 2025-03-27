import 'package:dio/dio.dart';
import 'package:grocery_store_app/helper/dio_client.dart';
import 'package:grocery_store_app/models/order_model.dart';

import '../models/checkout_model.dart';
import 'storage_service.dart';

class OrderService {
  Future<List<OrderModel>> fetchOrder() async {
    String? token = await StorageService.getToken();
    try {
      Response response = await DioClient.instance.get('/orders',
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
      Response response = await DioClient.instance.post(
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

  Future<OrderModel?> getOrderDetail(int orderId) async {
    String? token = await StorageService.getToken();
    try {
      Response response = await DioClient.instance.get(
        '/orders/$orderId',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      return OrderModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
