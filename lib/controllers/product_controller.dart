import 'package:flutter/foundation.dart';
import 'package:grocery_store_app/models/product_model.dart';
import 'package:grocery_store_app/services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();

  final List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = false;
  String _errorMessage = '';
  bool hasMore = true;
  int _currentPage = 1;

  List<ProductModel> get products =>
      _filteredProducts.isNotEmpty ? _filteredProducts : _allProducts;
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
      } else {
        hasMore = false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan saat mengambil produk';
    }

    _isLoading = false;
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = _allProducts
          .where(
            (product) => product.name!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }
}
