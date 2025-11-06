import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PopularMovie extends StatefulWidget {
  const PopularMovie({super.key});

  @override
  State<PopularMovie> createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  String _temp = "Waiting for response from API...";

  Future<String> fetchData() async {
    final response = await http.get(
        Uri.parse("https://ubaya.cloud/flutter/160422077/movie/movielist.php"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  void bacaData() {
    fetchData().then((value) {
      setState(() {
        _temp = value;
      });
    });
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
        body: Center(
          child: Text(_temp),
        )
    );
  }
}
