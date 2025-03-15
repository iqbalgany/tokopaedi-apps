import 'package:dio/dio.dart';
import 'package:grocery_store_app/model/cart_model.dart';
import 'package:grocery_store_app/services/storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/constants.dart';

class CartService {
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

  Future<List<CartModel>> getCarts() async {
    String? token = await StorageService.getToken();

    try {
      Response response = await dio.get(
        '/carts',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> cartData = response.data['data'];
        return cartData.map((json) => CartModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load carts');
      }
    } catch (e) {
      print('Error fetching carts: $e');
      throw Exception('Failed to load carts');
    }
  }

  Future<String> addToCart(int productId, int quantity) async {
    String? token = await StorageService.getToken();

    try {
      Response response = await dio.post(
        '/carts',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: {
          'product_id': productId.toString(),
          'quantity': quantity.toString(),
        },
      );

      return response.data['message'];
    } catch (e) {
      return 'Failed to add to cart';
    }
  }
}
