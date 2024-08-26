import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/features/data/categories.dart';
import 'package:shopping_list/features/data/dummy_list.dart';
import 'package:shopping_list/features/models/category_model.dart';
import 'package:shopping_list/features/models/grocery_item.dart';
import 'package:shopping_list/features/presentation/widgets/add_new_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https('udemyshoppinglist-2b304-default-rtdb.firebaseio.com',
        'shopping-list.json');

    final response = await http.get(url);
  //  print(response.body);

    final Map<String, dynamic> newList = jsonDecode(response.body);
  //  print(newList);
    final List<GroceryItem> _loadedItem = [];
    for (final item in newList.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      _loadedItem.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = _loadedItem;
    });
  }

  void _addItem() async {
    await Navigator.push<GroceryItem>(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNewItem(),
        ));
    _loadItem();
  }

  void _removeList(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text("Expense Deleted"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _groceryItems.add(item);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Y O U R   I T E M S"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _addItem();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: _groceryItems.isEmpty
          ? const Center(
              child: Text(
                "P L E A S E    A D D  S O M E    I T E M S",
                //  style: TextStyle(color: Colors.amber),
              ),
            )
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(_groceryItems[index].id),
                onDismissed: (direction) {
                  _removeList(_groceryItems[index]);
                },
                child: ListTile(
                  title: Text(_groceryItems[index].name),
                  trailing: Text(
                    _groceryItems[index].quantity.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryItems[index].category.color,
                  ),
                ),
              ),
            ),
    );
  }
}
