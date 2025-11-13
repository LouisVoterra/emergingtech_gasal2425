import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// Import halaman lain
import 'package:emergingtech_gasal2425_louis/Quiz.dart';
import 'package:emergingtech_gasal2425_louis/about.dart';
import 'package:emergingtech_gasal2425_louis/class/addrecipe.dart';
import 'basket.dart';
import 'home.dart';
import 'search.dart';
import 'history.dart';
import 'studentlist.dart';
import 'login.dart';
import 'animasi.dart';
import 'popularmovie.dart';
import 'personmovie.dart';
import 'login.dart';

// String active_user = "";



Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_name = prefs.getString("user_name") ?? '';
  return user_name;
}

//cara pak andre
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result){
    if (result == ""){
      runApp(MyLogin());
    }else{
      runApp(MyApp());
    }
  });
}
    

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   String result = await checkUser();

//   if (result.isEmpty) {
//     runApp(MyLogin());
//   } else {
//     active_user = result;
//     runApp(const MyApp());
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        'about': (context) => const About(),
        'basket': (context) => Basket(),
        'StudentList': (context) => const StudentList(),
        'AddRecipes': (context) => const AddRecipe(),
        'Quiz': (context) => const Quiz(),
        'login': (context) => MyLogin(),
        'Animasi': (context) => const Animasi(),
        'PopularMovie': (context) => const PopularMovie(),
        'PersonMovie': (context) => const PersonsMovie(),
      },
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

  //week 2
  int _currentIndex = 0;

  //week 2
  String smile = String.fromCharCodes(Runes('\u{1F60B}'));
  String angry = String.fromCharCodes(Runes('\u{1F621}'));
  String emo = "";

  //week 2
  final List<Widget> _screens = [Home(), Search(), History()];
  final List<String> _titles = ["Home", "Search", "History"];

  //week 6
  String _user_name = "";

  @override
  void initState() {
    super.initState();
    checkUser().then((value) {
      setState(() {
        _user_name = value;
      });
    });
  }

  void doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => doLogout(),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text("Gilbert Maynard Saragih"),
              accountEmail: Text(_user_name == "" ? "Loading..." : _user_name),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://my.ubaya.ac.id/img/mhs/160422075_l.jpg",
                ),
              ),
            ),
            ListTile(
              title: const Text("Inbox"),
              leading: const Icon(Icons.inbox),
              onTap: () {},
            ),
            ListTile(
              title: const Text("My Basket"),
              leading: const Icon(Icons.shopping_basket),
              onTap: () {
                Navigator.pushNamed(context, "basket");
              },
            ),
            ListTile(
              title: const Text("About"),
              leading: const Icon(Icons.help),
              onTap: () {
                Navigator.pushNamed(context, "about");
              },
            ),
            ListTile(
              title: const Text("Student List"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(context, "StudentList");
              },
            ),
            ListTile(
              title: const Text("Add Recipe"),
              leading: const Icon(Icons.add),
              onTap: () {
                Navigator.pushNamed(context, "AddRecipes");
              },
            ),
            ListTile(
              title: const Text("Quiz"),
              leading: const Icon(Icons.book),
              onTap: () {
                Navigator.pushNamed(context, "Quiz");
              },
            ),
            ListTile(
              title: const Text("Animasi"),
              leading: const Icon(Icons.piano),
              onTap: () {
                Navigator.pushNamed(context, "Animasi");
              },
            ),
            ListTile(
              title: const Text("Popular Movie"),
              leading: const Icon(Icons.movie),
              onTap: () {
                Navigator.pushNamed(context, "PopularMovie");
              },
            ),
            ListTile(
              title: const Text("Person Movie"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(context, "PersonMovie");
              },
            ),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
              onTap: () {
                doLogout();
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
