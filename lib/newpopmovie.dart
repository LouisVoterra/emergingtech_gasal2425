import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class NewPopMovie extends StatefulWidget {
  const NewPopMovie({super.key});

  @override
  State<NewPopMovie> createState() => _NewPopMovieState();
}

class _NewPopMovieState extends State<NewPopMovie> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _homepage = "";
  String _overview = "";
  String _posterUrl = "";
  String _runtime = "";
  final _controllerDate = TextEditingController();
  int count = 0;


  Future <bool> validateImage(String imageUrl) async {
    http.Response resp; 
    try{
      resp = await http.get(Uri.parse(imageUrl));
    }catch(e){
      return false;
    }
    if (resp.statusCode != 200) return false;
    Map <String, dynamic> data = resp.headers;
    if (data['content-type'] == 'image/jpeg' || data['content-type'] == 'image/png' || data['content-type'] == 'image/gif'){
      return true;
    }
    return false;
  }


  void submit() async {
    final response = await http
        .post(Uri.parse("https://ubaya.cloud/flutter/160422077/movie/newmovie.php"), body: {
      'title': _title,
      'overview': _overview,
      'homepage': _homepage,
      'release_date': _controllerDate.text,
      'runtime': _runtime,
      'url':_posterUrl,
    });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses Menambah Data')));

            
        // _formKey.currentState!.reset();
        // _controllerDate.clear();
        // setState(() {
        //   _title = "";
        //   _title = "";
        //   _homepage = "";
        //   _overview = "";
        //   _posterUrl = "";
        //   _runtime = "";
        
        // });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error')));
      throw Exception('Failed to read API');
    }
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("New Popular Movie"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Movie Title',
                ),
                onChanged: (value) {
                  _title = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Judul harus diisi';
                  }else{
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Homepage',
                ),
                onChanged: (value) {
                  _homepage = value;
                },
                validator: (value) {
                  if (value == null || !Uri.parse(value).isAbsolute) {
                    return 'alamat homepage salah';
                  }
                  return null;
                },
              )
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Overview',
                ),
                
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 6,
                validator: (value){
                  if (value == null || value == ""){
                    return "Oveview harus diisi";
                  }
                  if (value.length < 30){
                    return 'minimal 30 karakter';
                  }
                  return null; //lolos validasi
                },

              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Poster URL'),
                  
                  onChanged: (value) {
                    validateImage(value).then((isValid) {
                      if (isValid) {
                        setState(() {
                          _posterUrl = value; 
                        });
                      } 
                    });
                  },
                ),
              ),
            if (_posterUrl.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    _posterUrl, 
                    height: 200, 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                       return const Text("Gagal memuat gambar");
                    },
                  ),
                ),
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
                      controller: _controllerDate,
                    )
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context:context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2200)).then((value){
                          setState(() {
                            _controllerDate.text = value.toString().substring(0,10);
                          });
                        });
                    },
                    child: Icon(
                      Icons.calendar_today_sharp,
                      color: Colors.white,
                      size: 24.0
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Runtime',
                ),
                onChanged: (value) {
                  _runtime = value;
                },
                validator: (value) {
                  if (value == null || value == ""){
                    return 'Runtime harus diisi';
                  }else{
                    return null;
                  }
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState != null && !_formKey.currentState!.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Harap di isi ya')));
                  }
                  else{
                    submit();
                  }
                },
                child: const Text('Submit')
              ),
              ),
          ],
        ),
      ),
    );
  }
}