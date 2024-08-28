import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/features/data/categories.dart';
import 'package:shopping_list/features/models/grocery_item.dart';
import 'package:shopping_list/features/presentation/widgets/add_new_item.dart';
import 'package:shopping_list/features/presentation/widgets/skelton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroceryItem> _groceryItems = [];

  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https('udemyshoppinglist-2b304-default-rtdb.firebaseio.com',
        'shopping-list.json');

    final response = await http.get(url);
    print("${response.statusCode}here---------------+++++");
    print("N O T H I N G -------------)++++++++");

    if (response.statusCode >= 400) {
      setState(() {
        _error = "Failed to fetch data Something went wrong";
      });
    }

    final Map<String, dynamic> newList = jsonDecode(response.body);
    //  print(newList);
    final List<GroceryItem> loadedItem = [];
    for (final item in newList.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItem.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = loadedItem;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.push<GroceryItem>(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNewItem(),
        ));

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeList(GroceryItem item) async {
    setState(() {
      _groceryItems.remove(item);
    });

    final index = _groceryItems.indexOf(item);
    final url = Uri.https('udemyshoppinglist-2b304-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final resoponse = await http.delete(url);
    if (resoponse.statusCode >= 400) {
     setState(() {
        _groceryItems.insert(index, item);
     });
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text(
          "Expense Deleted",
        ),
        behavior: SnackBarBehavior.floating,
        // action: SnackBarAction(
        //     label: "Undo",
        //     onPressed: () {
        //       setState(() {
        //         _groceryItems.add(item);
        //       });
        //     }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        "P L E A S E    A D D  S O M E    I T E M S",
        //  style: TextStyle(color: Colors.amber),
      ),
    );
    if (_isLoading) {
      content = ListView.builder(
        itemBuilder: (context, index) => const SkeltonLoading(),
        itemCount: 14,
      );
    }
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
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
      );
    }
    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

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
        body: content);
  }
}
