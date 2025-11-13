import 'dart:convert';

import 'package:emergingtech_gasal2425_louis/class/popmovie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'popularmovie.dart';

class Detailpop extends StatefulWidget {
  int movieID;
  Detailpop(
    {
      required this.movieID
      }
  );

  @override
  State<StatefulWidget> createState() {
    return _DetailpopState();
  }
}

class _DetailpopState extends State<Detailpop> {
  PopMovie? _pm;
  
  Future <String> fetchData() async {
    final response = await http.post(Uri.parse("https://ubaya.cloud/flutter/160422077/movie/detailmovie.php"),
    body: {'id': widget.movieID.toString()}); //ngirim data pake post
    if (response.statusCode == 200) {
      return response.body; //retun string, jadi future juga harus string
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  BacaData(){
    fetchData().then((value){
      Map json = jsonDecode(value);
      _pm = PopMovie.fromJson(json['data']);
      setState(() { 
      });
    });
  }


  @override
  void initState() {
    super.initState();
    BacaData();
    //fetch detail movie by id
  }

  Widget tampilData(){
    if (_pm == null){
      return const CircularProgressIndicator();
    } else {
      return Card(
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(_pm!.title, style: const TextStyle(fontSize: 25)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_pm!.overview, style: const TextStyle(fontSize: 15))),
              const Padding(padding: EdgeInsets.all(10), child: Text("Genre:")),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pm?.genres?.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(_pm?.genres?[index]['genre_name']);
                    }))
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail of Popular Movies"),
      ),
      body: ListView(
        children: <Widget>[
          // Text(widget.movieID.toString()),
          tampilData(),
        ],
      )
    );
  }
}
