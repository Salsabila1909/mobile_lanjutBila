import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome Pemrograman Mobile!!"),
        ),
        body: const Center(
          child: Text(
            "Halo Semuanya",
            //maxLines: 2,
            //overflow: TextOverFlow.ellipsis,
            style: TextStyle(
                backgroundColor: Colors.amber,
                color: Colors.white,
                fontSize: 30),
          ),
        ),
      ),
    );
  }
}
