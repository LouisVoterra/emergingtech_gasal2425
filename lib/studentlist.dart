import 'package:flutter/material.dart';
import 'studentdetail.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student List')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StudentDetail(id: 70,)));
              },
              child: const Text("Student #id 70")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StudentDetail(id: 56,)));
              },
              child: const Text("Student #id 56")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StudentDetail(id:17)));
              },
              child: const Text("Student #id 17")),
        ]),
      )
    );
  }
}