import 'package:flutter/material.dart';
import 'itembasket.dart';
import '../class/recipe.dart'; // <-- import file recipe.dart

class Basket extends StatelessWidget {
  const Basket({super.key});

  List<Widget> widRecipes() {
    List<Widget> temp = [];
    int i = 0;
    while (i < recipes.length) { // <-- langsung pakai recipes dari recipe.dart
      Widget w = Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(128, 128, 128, 0.5),
            spreadRadius: -6,
            blurRadius: 8,
            offset: const Offset(8, 7),
          ),
        ]),
        child: Card(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: Text(
                  recipes[i].name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Image.network(recipes[i].photo),
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(recipes[i].desc),
              ),
            ],
          ),
        ),
      );
      temp.add(w);
      i++;
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basket')),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "This is Basket",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ...widRecipes(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ItemBasket(1, 10)),
              );
            },
            child: const Text("Item 1"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ItemBasket(2, 14)),
              );
            },
            child: const Text("Item 2"),
          ),
        ],
      ),
    );
  }
}
