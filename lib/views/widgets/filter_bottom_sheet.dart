import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/product_controller.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedCategory;
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Filter Produk',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField(
            value: _selectedCategory,
            hint: Text('Pilih kategori'),
            isExpanded: true,
            items: productController.categories.map(
              (category) {
                return DropdownMenuItem(
                  value: category.id.toString(),
                  child: Text(category.name),
                );
              },
            ).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ),
        ],
      ),
    );
  }
}
