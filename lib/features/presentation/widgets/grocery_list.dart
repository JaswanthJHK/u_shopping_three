import 'package:flutter/material.dart';
import 'package:shopping_list/features/data/dummy_list.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Y O U R   I T E M S"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(groceryItems[index].name),
          trailing: Text(groceryItems[index].quantity as String),
        ),
      ),
    );
  }
}
