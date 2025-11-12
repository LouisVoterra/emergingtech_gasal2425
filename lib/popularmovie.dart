import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'class/popmovie.dart';

class PopularMovie extends StatefulWidget {
  const PopularMovie({super.key});

  @override
  State<PopularMovie> createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  String _temp = "waiting API respond . . .";
  List <PopMovie> PMs = [];

  //kadang lemot kadang cepet
  Future<String> fetchData() async {
    //await ini intinya nunggu sampai data datang
    final response = await http.get(Uri.parse("https://ubaya.cloud/flutter/160422077/movie/movielist.php"));
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
      for (var mov in json['data']){
       PopMovie pm = PopMovie.fromJson(mov);
       PMs.add(pm); 
      }
      setState(() {
        _temp = PMs[2].overview;
      });
    });
  }

  Widget DaftarPopMovie(PopMovs) {
    if (PopMovs != null){
      return ListView.builder(
        itemCount: PopMovs.length,
        itemBuilder: (BuildContext ctx, int index){
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.movie),
                  title: Text(PopMovs[index].title),
                  subtitle: Text(PopMovs[index].overview),
                )
              ],
            ),
          );
      });
    }else {
      return const CircularProgressIndicator(); //kalo datanya null, tampilkan loading
    }
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Popular Movie"),
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height-200,
              child: DaftarPopMovie(PMs),
            )
          ],
        ),
    );
  }
}
