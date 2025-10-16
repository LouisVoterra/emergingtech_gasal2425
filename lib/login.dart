import 'package:flutter/material.dart';
import 'main.dart';

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  String _email = "";
  String _password = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        height: 300,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 5)]),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (v) {
                  _email = v;
                  active_user = v;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (v) {
                  _password = v;
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                    // Contoh sederhana — login tanpa validasi
                    if (_email.isNotEmpty && _password.isNotEmpty) {
                      doLogin(_email, context); // simpan ke SharedPreferences & arahkan ke MyApp
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email dan Password tidak boleh kosong")),
                      );
                    }
                  },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                )),
		      ]),
   ));
  }
}

