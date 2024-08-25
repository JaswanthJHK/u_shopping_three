import 'package:flutter/material.dart';
import 'package:shopping_list/features/models/grocery_item.dart';
import 'package:shopping_list/features/presentation/widgets/add_new_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<GroceryItem> _groceryItems = [];
  void _addItem() async {
    final newItem = await Navigator.push<GroceryItem>(
        context,
        MaterialPageRoute(
          builder: (context) =>const AddNewItem(),
        ));

    if (newItem == null) {
      return;
    }
    setState(() {
          _groceryItems.add(newItem);

    });
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
      body: ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_groceryItems[index].name),
          trailing: Text(
            _groceryItems[index].quantity.toString(),
            style:const TextStyle(fontSize: 25),
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
}
