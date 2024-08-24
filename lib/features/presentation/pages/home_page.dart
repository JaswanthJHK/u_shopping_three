import 'package:flutter/material.dart';
import 'package:shopping_list/features/data/categories.dart';
import 'package:shopping_list/features/data/dummy_list.dart';
import 'package:shopping_list/features/models/category_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          trailing: Container(
            height: 
            10,
            width: 10,
            
          ),
         
        );
      },
    ));
  }
}
