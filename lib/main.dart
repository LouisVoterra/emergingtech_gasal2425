import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

String active_user = "";




Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  return user_id;
}

Future<void> doLogin(String userId, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("user_id", userId);
  active_user = userId;

// void doLogin() async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString("user_id", active_user);
//   main();

  // arahkan ke halaman utama, bukan panggil main()
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const MyApp()),
  );
}

Future<void> doLogout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("user_id");
  active_user = "";

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => MyLogin()),
  );
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
      routes: {
        'about': (context) => const About(),
        'basket': (context) => Basket(),
        'StudentList': (context) => const StudentList(),
        'AddRecipes': (context) => const AddRecipe(),
        'Quiz': (context) => const Quiz(),
        'login': (context) => MyLogin(),
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
  int _currentIndex = 0;
  final List<Widget> _screens = [Home(), Search(), History()];
  final List<String> _titles = ["Home", "Search", "History"];

  @override
  void initState() {
    super.initState();
    checkUser().then((value) {
      setState(() {
        active_user = value;
      });
    });
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
            onPressed: () => doLogout(context),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text("Louis Dewa Voterra"),
              accountEmail: Text(active_user.isEmpty ? "Loading..." : active_user),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://my.ubaya.ac.id/img/mhs/160422077_l.jpg",
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
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
              onTap: () {
                doLogout(context);
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
