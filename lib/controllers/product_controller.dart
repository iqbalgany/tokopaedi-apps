import 'package:flutter/foundation.dart';
import 'package:grocery_store_app/model/product_model.dart';
import 'package:grocery_store_app/services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductModel> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';
  bool hasMore = true;
  int _currentPage = 1;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchProducts({bool isLoadMore = false}) async {
    if (_isLoading || !hasMore) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      List<ProductModel> fetchedProducts =
          await _productService.getProducts(page: _currentPage);

      if (fetchedProducts.isNotEmpty) {
        if (isLoadMore) {
          _products.addAll(fetchedProducts);
        } else {
          _products = fetchedProducts;
        }
        _currentPage++;
      } else {
        hasMore = false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalah saat mengambil produk';
    }

    _isLoading = false;
    notifyListeners();
  }
}
