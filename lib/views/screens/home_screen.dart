import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/cart_controller.dart';
import 'package:grocery_store_app/controllers/product_controller.dart';
import 'package:grocery_store_app/models/product_model.dart';
import 'package:grocery_store_app/views/widgets/cart_icon.dart';
import 'package:grocery_store_app/views/widgets/filter_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  void loadCart() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      await Provider.of<ProductController>(context, listen: false)
          .fetchProducts();
    } catch (e) {
      rethrow;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadCart();
      Provider.of<ProductController>(context, listen: false).fetchCategories();
    });

    _scrollController.addListener(
      () {
        final productController =
            Provider.of<ProductController>(context, listen: false);

        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          if (!productController.isLoading && productController.hasMore) {
            productController.fetchProducts(isLoadMore: true);
          }
        }
      },
    );
  }

  void _onSearchChanged() {
    final productController =
        Provider.of<ProductController>(context, listen: false);
    productController.filterProducts(name: _searchController.text);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = context.watch<CartController>().totalItems;

    final productController = Provider.of<ProductController>(context);
    final cartController = Provider.of<CartController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (value) {
                        productController.filterProducts(name: value);
                      },
                      focusNode: _searchFocusNode,
                      controller: _searchController,
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Item',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                        focusedBorder: OutlineInputBorder(
                          gapPadding: 15,
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        border: OutlineInputBorder(
                          gapPadding: 15,
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const FilterBottomSheet(),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.menu),
                ),
                CartIcon(
                  totalItems: totalItems,
                )
              ],
            ),
            const Divider(),
            Expanded(
              child: Consumer<ProductController>(
                builder: (context, productController, _) {
                  return ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.all(0),
                    controller: _scrollController,
                    itemCount:
                        _isLoading ? 8 : productController.products.length,
                    itemBuilder: (context, index) {
                      if (_isLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        ProductModel product =
                            productController.products[index];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: ListTile(
                            onTap: () async {
                              await cartController.addToCart(product.id!, 1);
                            },
                            leading: Image.network(
                              product.image!,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                            title: Text(
                              product.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.description!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  product.category!.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              'Rp${NumberFormat("#,###", "id_ID").format(product.price)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
