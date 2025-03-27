import 'package:flutter/foundation.dart';
import 'package:grocery_store_app/helper/debouncer.dart';
import 'package:grocery_store_app/models/category_model.dart';
import 'package:grocery_store_app/models/product_model.dart';
import 'package:grocery_store_app/services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  List<ProductModel> _products = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  bool hasMore = true;
  int _currentPage = 1;

  String? _searchQuery;
  String? _selectedCategory;
  String? _minPrice;
  String? _maxPrice;

  String? get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  String? get minPrice => _minPrice;
  String? get maxPrice => _maxPrice;
  List<ProductModel> get products => _products;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts({
    bool isLoadMore = false,
  }) async {
    if (_isLoading || !hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      List<ProductModel> fetchedProducts = await _productService.getProducts(
        page: isLoadMore ? _currentPage : 1,
        name: _searchQuery,
        categoryId: _selectedCategory,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
      );

      if (!isLoadMore) {
        _products = fetchedProducts;
        _currentPage = 2;
      } else {
        if (fetchedProducts.isNotEmpty) {
          _products.addAll(fetchedProducts);
          _currentPage++;
        } else {
          hasMore = false;
        }
      }
    } catch (e) {
      throw 'Error fetching products: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _productService.getCategories();
      notifyListeners();
    } catch (e) {
      throw 'Error fetching categories: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterProducts({
    String? name,
    String? categoryId,
    String? minPrice,
    String? maxPrice,
  }) {
    _debouncer.run(
      () {
        _searchQuery = name;
        _selectedCategory = categoryId;
        _minPrice = minPrice;
        _maxPrice = maxPrice;
        hasMore = true;
        _currentPage = 1;

        _products = [];
        notifyListeners();

        fetchProducts(isLoadMore: false);
      },
    );
  }
}
