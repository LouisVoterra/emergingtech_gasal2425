import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'class/personmov.dart';

class PersonsMovie extends StatefulWidget {
  const PersonsMovie({super.key});

  @override
  State<PersonsMovie> createState() => _PersonsMovieState();
}

class _PersonsMovieState extends State<PersonsMovie>{
  String _temp = "waiting API respond . . .";
  List <PersonMovie> PsMs = [];

  //kadang lemot kadang cepet
  Future<String> fetchData() async {
    //await ini intinya nunggu sampai data datang
    final response = await http.get(Uri.parse("https://ubaya.cloud/flutter/160422077/movie/personlist.php"));
    if (response.statusCode == 200) {
      return response.body; //retun string, jadi future juga harus string
    } else {
      throw Exception('Failed to load data from API');
    } 
  } 
  
  bacaData() {
    //memanggil fungsi fetchData
    Future<String> data = fetchData();
    data.then((value){
      Map json = jsonDecode(value);
      for (var pmov in json['data']){
       PersonMovie pm = PersonMovie.fromJson(pmov);
       PsMs.add(pm); 
      }
      setState(() {
        _temp = PsMs[1].name;
      });
    });
  }

  Widget DaftarPersonMovies(PersMovs){
    if (PersMovs != null){
      return ListView.builder(
        itemCount: PersMovs.length,
        itemBuilder: (BuildContext ctx, int index){
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(PersMovs[index].name + " - " + PersMovs[index].character)

                )
              ]
            )
          );
        },
      );
    }
    else{
      return const CircularProgressIndicator();
    }
  }
  
  @override
  void initState(){
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Person Actor-Actress"),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height-200,
            child: DaftarPersonMovies(PsMs),
          )
        ],
      )
    );
  }
}
