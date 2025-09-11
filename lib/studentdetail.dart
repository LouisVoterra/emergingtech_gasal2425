import 'package:flutter/material.dart';

class StudentDetail extends StatelessWidget {
  final int id;
  const StudentDetail({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Detail')),
      body: Center
      (child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300?img=$id",
              ),
            ),
            const SizedBox(height: 20),
            Text("Student ID: $id",
                style: const TextStyle(fontSize: 18)),
          ],
      )
      ),
    );
  }
}