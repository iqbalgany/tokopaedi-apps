import 'package:dio/dio.dart';
import 'package:grocery_store_app/models/product_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/constants.dart';

class ProductService {
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

  Future<List<ProductModel>> getProducts({
    int page = 1,
    String? name,
    String? categoryId,
    String? minPrice,
    String? maxPrice,
  }) async {
    try {
      Response response = await dio.get('/products', queryParameters: {
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
      print('Error fetching products: $e');
      rethrow;
    }
  }
}
