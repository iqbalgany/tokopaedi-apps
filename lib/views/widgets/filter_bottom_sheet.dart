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
  void initState() {
    super.initState();

    final productController =
        Provider.of<ProductController>(context, listen: false);

    selectedCategories =
        Set.from(productController.selectedCategory?.split(',') ?? []);
    _minPriceController.text = productController.minPrice ?? '';
    _maxPriceController.text = productController.maxPrice ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final productController =
        Provider.of<ProductController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              const Text(
                'Filter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategories.clear();
                    _minPriceController.clear();
                    _maxPriceController.clear();
                  });
                  productController.clearFilters();
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productController.categories.length,
              itemBuilder: (context, index) {
                final category = productController.categories[index];
                final isSelected =
                    selectedCategories.contains(category.id.toString());
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedCategories.contains(category.id.toString())) {
                        selectedCategories.remove(category.id.toString());
                      } else {
                        selectedCategories.add(category.id.toString());
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(10),
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
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Min Price',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
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
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _maxPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Max Price',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
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
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              productController.filterProducts(
                name: productController.searchQuery,
                categoryId: selectedCategories.isNotEmpty
                    ? selectedCategories.join(',')
                    : productController.selectedCategory,
                minPrice: _minPriceController.text.isNotEmpty
                    ? _minPriceController.text
                    : productController.minPrice,
                maxPrice: _maxPriceController.text.isNotEmpty
                    ? _maxPriceController.text
                    : productController.maxPrice,
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
