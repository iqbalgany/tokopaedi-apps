import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/product_controller.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  Set<String> selectedCategories = {};
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 60,
              height: 3,
              decoration: const BoxDecoration(color: Colors.green),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Filter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productController.categories.length,
              itemBuilder: (context, index) {
                final category = productController.categories[index];
                final isSelected = selectedCategories.contains(category.id);
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected ? Colors.green : Colors.white,
                    ),
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Min Price',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _maxPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Max Price',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              productController.filterProducts(
                categoryId: selectedCategories.isNotEmpty
                    ? selectedCategories.join(',')
                    : null,
                minPrice: _minPriceController.text.isNotEmpty
                    ? _minPriceController.text
                    : null,
                maxPrice: _maxPriceController.text.isNotEmpty
                    ? _maxPriceController.text
                    : null,
              );
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              width: MediaQuery.sizeOf(context).width,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: const Center(
                child: Text(
                  'Filter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
