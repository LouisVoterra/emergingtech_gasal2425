import 'dart:convert';

import 'package:emergingtech_gasal2425_louis/detailmovie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'class/popmovie.dart';
import 'detailmovie.dart';

class PopularMovie extends StatefulWidget {
  const PopularMovie({super.key});

  @override
  State<PopularMovie> createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  String _temp = "waiting API respond . . .";
  String _txtcari = "";

  List <PopMovie> PMs = [];

  //kadang lemot kadang cepet
  Future<String> fetchData() async {
    //await ini intinya nunggu sampai data datang
    final response = await http.post(Uri.parse("https://ubaya.cloud/flutter/160422077/movie/movielist.php"),
    body: {'cari': _txtcari} //ngirim data pake post
);
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
        PMs.clear();
        if(json['result']=='success'){ 
          for (var mov in json['data']){
          PopMovie pm = PopMovie.fromJson(mov);
          PMs.add(pm); 
          }
        }
        setState(() {
            // _temp = PMs[0].title;
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
                  title: GestureDetector(
                    child: Text(PopMovs[index].title),
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => Detailpop(movieID: PMs[index].id,)
                        ),
                      );
                    }
                  ),
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
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                labelText: 'Judul mengandung kata:',
              ),
              onFieldSubmitted: (value){
                _txtcari = value;
                PMs.clear();
                bacaData();
              },
            ),

            Container(
              height: MediaQuery.of(context).size.height-200,
              child: PMs.length > 0 ? DaftarPopMovie(PMs):Text('tidak ada data'),
            )
          ],
        ),
    );
  }
}


