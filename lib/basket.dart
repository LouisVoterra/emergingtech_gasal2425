import 'package:flutter/material.dart';
import 'itembasket.dart';

class Basket extends StatelessWidget {
  const Basket({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Basket')),
      body: Center(
        child: Column(children: [
          const Text("This is Basket"),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ItemBasket(1, 10)));
              },
              child: const Text("Item 1")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ItemBasket(2, 14)));
              },
              child: const Text("Item 2"))
        ]),
      )
      
    );
  }
}