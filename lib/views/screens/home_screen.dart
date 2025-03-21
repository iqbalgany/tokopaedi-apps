import 'package:flutter/material.dart';
import 'package:grocery_store_app/constants/app_routes.dart';
import 'package:grocery_store_app/controllers/cart_controller.dart';
import 'package:grocery_store_app/controllers/product_controller.dart';
import 'package:grocery_store_app/models/product_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final productController =
          Provider.of<ProductController>(context, listen: false);
      await productController.fetchProducts();
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = context.watch<CartController>().totalItems;

    final productController = Provider.of<ProductController>(context);
    final cartController = Provider.of<CartController>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          ListTile(
            title: TextField(
              cursorColor: Colors.green,
              decoration: InputDecoration(
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
            trailing: CartIcon(
              totalItems: totalItems,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              controller: _scrollController,
              itemCount: productController.products.isEmpty
                  ? productController.products.length + 1
                  : productController.products.length + 1,
              itemBuilder: (context, index) {
                if (productController.products.isEmpty) {
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
                }
                if (index < productController.products.length) {
                  ProductModel product = productController.products[index];
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 100),
                            content: Text(
                                cartController.message ?? 'Added to cart!'),
                          ),
                        );
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
                } else {
                  return productController.hasMore
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartIcon extends StatelessWidget {
  final int totalItems;
  const CartIcon({
    super.key,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          icon: const Icon(Icons.shopping_basket_outlined),
        ),
        if (totalItems > 0)
          Positioned(
            right: 4,
            top: 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                textAlign: TextAlign.center,
                totalItems.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
