import 'package:shopping_list/features/models/category_model.dart';

class GroceryItem {
  final String id;
  final String name;
  final int quantity;
  final CategoryModel category;

  const GroceryItem({required this.id, required this.name, required this.quantity, required this.category});

  
}
