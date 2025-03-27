import 'package:dio/dio.dart';
import 'package:grocery_store_app/helper/dio_client.dart';
import 'package:grocery_store_app/models/cart_model.dart';
import 'package:grocery_store_app/services/storage_service.dart';

class CartService {
  Future<List<CartModel>> getCarts() async {
    String? token = await StorageService.getToken();

    try {
      Response response = await DioClient.instance.get(
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
      throw Exception('Failed to load carts');
    }
  }

  Future<String> addToCart(int productId, int quantity) async {
    String? token = await StorageService.getToken();

    try {
      Response response = await DioClient.instance.post(
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

  Future<bool> removeFromCart(int cartId) async {
    String? token = await StorageService.getToken();

    try {
      Response response = await DioClient.instance.post(
        '/carts/remove',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
        data: {'cart_id': cartId},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
