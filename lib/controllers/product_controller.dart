import 'package:flutter/foundation.dart';
import 'package:grocery_store_app/models/category_model.dart';
import 'package:grocery_store_app/models/product_model.dart';
import 'package:grocery_store_app/services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();

  final List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  String _errorMessage = '';
  bool hasMore = true;
  int _currentPage = 1;
  String? _selectedCategory;

  List<ProductModel> get products =>
      _filteredProducts.isNotEmpty ? _filteredProducts : _allProducts;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String? get selectedCategory => _selectedCategory;

  Future<void> fetchProducts({
    bool isLoadMore = false,
  }) async {
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

  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      List<CategoryModel> fetchedCategories =
          await _productService.getCategories();

      _categories = fetchedCategories;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal mengambil kategori';
    }

    _isLoading = false;
    notifyListeners();
  }

  void runFilter(String enteredKeyword) async {
    _isLoading = true;
    notifyListeners();

    try {
      _filteredProducts =
          await _productService.getProducts(name: enteredKeyword);
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan saat mengambil produk';
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(String? category) {
    _selectedCategory = category;
    _filteredProducts = category == null
        ? _allProducts
        : _allProducts
            .where((product) => product.category?.name == category)
            .toList();

    notifyListeners();
  }
}
