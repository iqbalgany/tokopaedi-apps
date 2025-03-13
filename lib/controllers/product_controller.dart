import 'package:flutter/foundation.dart';
import 'package:grocery_store_app/model/product_model.dart';
import 'package:grocery_store_app/services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductModel> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchProducts({
    int page = 1,
    String? name,
    String? categoryId,
    String? minPrice,
    String? maxPrice,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      List<ProductModel> fetchedProducts = await _productService.getProducts(
        page: page,
        name: name,
        categoryId: categoryId,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );

      _products = fetchedProducts;
    } catch (e) {
      _errorMessage = 'Terjadi kesalah saat mengambil produk';
    }

    _isLoading = false;
    notifyListeners();
  }
}
