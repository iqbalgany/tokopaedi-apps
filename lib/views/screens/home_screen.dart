import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store_app/model/cart_model.dart';
import 'package:grocery_store_app/views/widgets/grocery_item_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 48,
            ),

            /// GOOD MORNING
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text('Good moring, mate'),
            ),
            const SizedBox(
              height: 4,
            ),

            /// LET'S ORDER FRESH ITEMS FOR YOU
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Let\'s order fresh items for you',
                style: GoogleFonts.notoSerif(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            /// DIVIDER
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Divider(),
            ),

            /// FRESH ITEMS + GRID
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Fresh Items',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Consumer<CartModel>(
                builder: (context, value, child) => GridView.builder(
                  itemCount: value.shopItems.length,
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                      itemName: value.shopItems[index][0],
                      stock: 3,
                      description: 'Ini Barang',
                      itemPrice: value.shopItems[index][1],
                      imagePath: value.shopItems[index][2],
                      color: value.shopItems[index][3],
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .addItemToCart(index);
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }
}
