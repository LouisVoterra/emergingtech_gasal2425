import 'package:emergingtech_gasal2425_louis/Quiz.dart';
import 'package:emergingtech_gasal2425_louis/about.dart';
import 'package:emergingtech_gasal2425_louis/class/addrecipe.dart';
import 'package:flutter/material.dart';
import 'basket.dart';
import 'home.dart';
import 'search.dart';
import 'history.dart';
import 'studentlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: 
      {
        'about': (context) => const About(), //ada const ini gabisa diubah
        'basket': (context) => Basket(), //disini juga, tapi karena isi basket ada yang mau di ubah, jadi const diilangi
        'StudentList': (context) => const StudentList(),
        'AddRecipes': (context) => const AddRecipe(),
        'Quiz': (context) => const Quiz(),
        },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  // String _emojiText = "";

  int _currentIndex = 0;
  final List<Widget> _screens = [Home(), Search(), History()];
  final List<String> _titles = ["Home", "Search", "History"];


  // void _incrementCounter() {
  //   setState(() {
      
  //     // _counter++;
  //     // String result = "";
  //     // for (int i = 1; i <= _counter; i++) {
  //     //   if (i % 5 == 0) {
  //     //     result += String.fromCharCode(0x1F621); 
  //     //   } else {
  //     //     result += String.fromCharCode(0x1F600);
  //     //   }
  //     // }
  //     // _emojiText = result;
      
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.primary,
       
        title: Text(_titles[_currentIndex]),
      ),
      body: _screens[_currentIndex],
      // Center(
        
      //   child: Column(
          
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text('You have pushed the button this many times:'),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //       const Text('Nama : Louis Dewa Voterra'),
      //       const Text('NRP : 160422077'),
            
      //       const SizedBox(height: 20),
      //       Text(
      //         _emojiText.isEmpty ? "Belum ada emoji" : _emojiText,
      //         style: const TextStyle(fontSize: 30, color: Colors.black),
      //       )
      //     ],
      //   ),
      // ),
      
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), 
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Louis Dewa Voterra"),
              accountEmail: Text("s160422077@student.ubaya.ac.id"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://my.ubaya.ac.id/img/mhs/160422077_l.jpg"),
              ),
            ),
            ListTile(
              title: Text("Inbox"),
              leading: Icon(Icons.inbox),
              onTap: () {},
            ),
            ListTile(
              title: Text("My Basket"),
              leading: Icon(Icons.shopping_basket),
              onTap: () {
                Navigator.pushNamed(context, "basket"
                );
              },
            ),
            ListTile(
              title: const Text("About"),
              leading: const Icon(Icons.help),
              onTap: () {
                Navigator.pushNamed(
                  context,"about"
                  
                  // MaterialPageRoute(builder: (context) => const About()),
                );
              },
            ),
            ListTile(
              title: Text("Student List"),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(context, "StudentList"
                );
              },
            ),
            ListTile(
              title: Text("Add Recipe"),
              leading: Icon(Icons.add),
              onTap: () {
                Navigator.pushNamed(context, "AddRecipes"
                );
              },
            ),
            ListTile(
              title: Text("Quiz"),
              leading: Icon(Icons.book),
              onTap: () {
                Navigator.pushNamed(context, "Quiz"
                );
              },
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.skip_previous),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.skip_next),
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Icon(Icons.history),
          ),
    
          
        ],
       
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
