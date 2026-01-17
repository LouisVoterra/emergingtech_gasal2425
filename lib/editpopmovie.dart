import 'dart:convert';
import 'package:emergingtech_gasal2425_louis/class/popmovie.dart'; 

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'genre.dart';

class EditPopMovie extends StatefulWidget {
  final int movieID;
  const EditPopMovie({super.key, required this.movieID});

  @override
  EditPopMovieState createState() {
    return EditPopMovieState();
  }
}

class EditPopMovieState extends State<EditPopMovie> {
  final _formKey = GlobalKey<FormState>();
  PopMovie? _pm;
  
  final TextEditingController _titleCont = TextEditingController(); 
  final TextEditingController _homepageCont = TextEditingController();  
  final TextEditingController _overviewCont = TextEditingController(); 
  final TextEditingController _releaseDate = TextEditingController(); 
  final TextEditingController _runtimeCont = TextEditingController(); 
  final TextEditingController _urlCont = TextEditingController(); 
  Widget comboGenre = Text('tambah genre');

  Future<String> fetchData() async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160422077/movie/detailmovie.php"),
      body: {'id': widget.movieID.toString()}
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  void bacaData() {
    fetchData().then((value) {
      Map<String, dynamic> json = jsonDecode(value);
      _pm = PopMovie.fromJson(json['data']);
      setState(() {
        _titleCont.text = _pm!.title; 
        _homepageCont.text = _pm!.homepage;
        _overviewCont.text = _pm!.overview;
        _releaseDate.text = _pm!.release_date;
        _runtimeCont.text = _pm!.runtime;
        _urlCont.text = _pm!.url;
      });
    });
  }

  Future<bool> validateImage(String imageUrl) async {
    http.Response resp; 
    try{
      resp = await http.get(Uri.parse(imageUrl));
    } catch(e){
      return false;
    }
    if (resp.statusCode != 200) return false;
    Map<String, dynamic> data = resp.headers;
    if (data['content-type'] == 'image/jpeg' || data['content-type'] == 'image/png' || data['content-type'] == 'image/gif'){
      return true;
    }
    return false;
  }


  Future<List> daftarGenre() async {
    Map json;
    final response = await http.post(
    Uri.parse("https://ubaya.cloud/flutter/160422077/movie/genrelist.php"),
      body: {'movie_id': widget.movieID.toString()});
    
    if (response.statusCode == 200) {
      print(response.body);
      json = jsonDecode(response.body);
      return json['data'];
    } 
    else {
      throw Exception('Failed to read API');
  }
 }
 
 
 void generateComboGenre() {
  List<Genre> genres;
  var data = daftarGenre();
  data.then((value) {
   genres = List<Genre>.from(value.map((i) {
    return Genre.fromJSON(i);}));
    setState(() {
     comboGenre = DropdownButton(
    dropdownColor: Colors.grey[100],
     hint: const Text("tambah genre"),
     isDense: false,
     items: genres.map((gen) {
      return DropdownMenuItem(
       value: gen.genre_id,
       child: Column(children: <Widget>[
        Text(gen.genre_name, overflow: TextOverflow.visible),
       ]),
      );
     }).toList(),
     onChanged: (value) {
      addGenre(value);
     });
    }); 
  });
 }
  
  void addGenre(genre_id) async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160422077/movie/addmoviegenre.php"),
      body: {'genre_id': genre_id.toString(), 'movie_id': widget.movieID.toString()
      });
        if (response.statusCode == 200) {
          print(response.body);
          Map json = jsonDecode(response.body);
        if (json['result'] == 'success') {
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses menambah genre')));
          setState(() {
            bacaData();
          });
        }
      } else {
      throw Exception('Failed to read API');
      }
  }

  void deleteGenre(genre_id) async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160422077/movie/deletegenremovie.php"),
      body: {'genre_id': genre_id.toString(), 'movie_id': widget.movieID.toString()
      });
        if (response.statusCode == 200) {
          print(response.body);
          Map json = jsonDecode(response.body);
        if (json['result'] == 'success') {
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses menghapus genre')));
          setState(() {
            bacaData();
          });
        }
      } else {
      throw Exception('Failed to read API');
      }
    }

    


  void submit() async {
  final response = await http.post(
    Uri.parse("https://ubaya.cloud/flutter/160422077/movie/updatemovie.php"),
    body: {
     'title': _pm!.title,
     'overview': _pm!.overview,
     'homepage': _pm!.homepage,
      'release_date':_pm!.release_date,          
      'runtime':_pm!.runtime.toString(),
      'url':_urlCont.text,
     'movie_id': widget.movieID.toString()
    });
  if (response.statusCode == 200) {
   Map json = jsonDecode(response.body);
   if (json['result'] == 'success') {
        if (!mounted) return;
    ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('Sukses mengubah Data')));
   }
  } else {
   throw Exception('Failed to read API');
  }
 }


  @override
  void initState() {
    super.initState();
    bacaData();
    generateComboGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Popular Movie"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView( 
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text("ID: ${widget.movieID}"),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                  labelText: 'Title',
                  ),
                  onChanged: (value) {
                      _pm!.title = value;
                  },
                  controller: _titleCont,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'judul harus diisi';
                  }
                  return null;
                  },
              )),
              Padding(	
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Website',
                    ),
                    onChanged: (value) {
                      _pm!.homepage = value;
                    },
                    controller: _homepageCont,
                    validator: (value) {
                      if (value == null ||  !Uri.parse(value).isAbsolute) {
                        return 'alamat website salah';
                      }
                      return null;
                    },
                  )),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                  labelText: 'Overview',
                  ),
                  onChanged: (value) {
                  _pm!.overview = value;
                  },
                  controller: _overviewCont,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 6,
                )),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Expanded(
                    child: TextFormField(
                    decoration: const InputDecoration(
                    labelText: 'Release Date',
                    ),
                    controller: _releaseDate,
                     onChanged: (value) {
                       _pm!.release_date = value;
                    },
                  )),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200))
                        .then((value) {
                      setState(() {
                        _releaseDate.text =
                          value.toString().substring(0, 10);
                      });
                      });
                    },
                    child: Icon(
                      Icons.calendar_today_sharp,
                      color: Colors.white,
                      size: 24.0,
                    ))
                  ],
                )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                  labelText: 'Runtime',
                  ),
                  controller: _runtimeCont,
                  onChanged: (value){
                    _pm!.runtime = value;
                  },
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Runtime harus diisi';
                  }
                  return null;
                  },
              )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                  decoration: const InputDecoration(
                          labelText: 'URL Poster',
                  ),
                                onChanged: (value) {
                                  validateImage(value).then((v) {
                                  setState(() {
                                      });
                                    }
                                  );
                                },
                                controller: _urlCont,
                  validator: (value) {
                          if (value == null || !Uri.parse(value).isAbsolute) {
                            return 'alamat url salah';
                          }
                          return null;
                      },
                )),
                    if(_urlCont.text!='') Image.network(_urlCont.text),
                
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                        submit();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Sukses update data!"))
                        );
                        
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Harap Isian diperbaiki')));
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(10), child: Text('Genre:')),
                if(_pm != null)
                Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _pm!.genres!.length ?? 0,
                  itemBuilder: (BuildContext ctxt, int index) {
                   return ListTile(
                     title: Text(_pm!.genres![index]['genre_name']),
                     trailing: IconButton(
                      onPressed: (){
                        int idGenre = _pm!.genres![index]['genre_id'];
                        deleteGenre(idGenre);
                      }, 
                      icon: const Icon(Icons.close, color: Colors.red,)),
                   );
                  })),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: comboGenre),
            ],
          ),
        ),
      ),
    );
  }
}