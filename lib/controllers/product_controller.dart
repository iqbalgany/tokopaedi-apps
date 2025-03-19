import 'package:flutter/foundation.dart';
import 'package:grocery_store_app/model/product_model.dart';
import 'package:grocery_store_app/services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();

  final List<ProductModel> _allProducts = [];
  List<ProductModel> _displayedProducts = [];
  bool _isLoading = false;
  String _errorMessage = '';
  bool hasMore = true;
  int _currentPage = 1;

  List<ProductModel> get products => _displayedProducts;
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
        _allProducts.addAll(fetchedProducts);
        _currentPage++;

        if (!isLoadMore) {
          _displayedProducts = _allProducts.take(8).toList();
        } else {
          _displayedProducts = List.from(_allProducts);
        }
      } else {
        hasMore = false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan saat mengambil produk';
    }

    _isLoading = false;
    notifyListeners();
  }
}
