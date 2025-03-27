import 'package:dio/dio.dart';
import 'package:grocery_store_app/helper/dio_client.dart';
import 'package:grocery_store_app/models/category_model.dart';
import 'package:grocery_store_app/models/product_model.dart';

class ProductService {
  Future<List<ProductModel>> getProducts({
    int page = 1,
    String? name,
    String? categoryId,
    String? minPrice,
    String? maxPrice,
  }) async {
    try {
      Response response =
          await DioClient.instance.get('/products', queryParameters: {
        'page': page,
        'name': name,
        'category_id': categoryId,
        'min_price': minPrice,
        'max_price': maxPrice,
      });

      List<ProductModel> products = (response.data['data'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      Response response = await DioClient.instance.get('/categories');

      List<CategoryModel> categories = (response.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      return categories;
    } catch (e) {
      rethrow;
    }
  }
}
