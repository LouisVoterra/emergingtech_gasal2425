import 'package:flutter/material.dart';
 import 'dart:math';

class About extends StatelessWidget {
  const About({super.key});

  List<Widget> randomphotos() {
    List<Widget> temp = [];
    int i = 0;
    final random = Random();

    while (i < 15) {
      int randomNumber = random.nextInt(1084) + 1;
      Widget w = Image.network(
        "https://picsum.photos/id/$randomNumber/200/200",
      );
      temp.add(w);
      i++;
    }
    return temp;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container dengan AspectRatio
            Container(
              color: Colors.yellow,
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: AspectRatio(
                aspectRatio: 4 / 1,
                child: Container(
                  color: Colors.red,
                ),
              ),
            ),

            // Container dengan Card
            Container(
              color: Colors.cyan,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: 300,
              width: 300,
              child: const Card(
                child: Center(
                  child: Text("Hello World!"),
                ),
              ),
            ),

            // Container dengan gambar lingkaran
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/400?img=60'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.indigo,
                  width: 10,
                ),
                shape: BoxShape.circle,
                // NOTE: Tidak bisa pakai borderRadius bersamaan dengan shape: BoxShape.circle
                // borderRadius: const BorderRadius.all(Radius.circular(60)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network('https://i.pravatar.cc/100?img=1'),
                  Image.network('https://i.pravatar.cc/100?img=2'),
                  Image.network('https://i.pravatar.cc/100?img=3'),
                ],
            ),
            const Divider(
                height: 20,
              ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network('https://i.pravatar.cc/100?img=10'),
                  Image.network('https://i.pravatar.cc/100?img=11'),
                  Image.network('https://i.pravatar.cc/100?img=12'),
                  Image.network('https://i.pravatar.cc/100?img=13'),
                  Image.network('https://i.pravatar.cc/100?img=14'),
                  Image.network('https://i.pravatar.cc/100?img=15'),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity, // stretch 
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ), // rounded corners
                    image: DecorationImage(
                      image: NetworkImage("https://placecats.com/neo/300/200"),
                      fit: BoxFit.cover, // aspect ratio dijaga
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "../assets/missing.png",
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: randomphotos(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
