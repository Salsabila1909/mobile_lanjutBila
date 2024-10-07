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
            title: const Text("My App"),
          ),
          body: ListView(
            children: const [
              ListTile(
                title: Text("Sandika Rahardi"),
                subtitle: Text("This is subtitle okay.."),
                leading: CircleAvatar(),
                trailing: Text("10:00 PM"),
              ),
              ListTile(
                title: Text("Tiara Nurmanda"),
                subtitle: Text("How are you okay.."),
                leading: CircleAvatar(),
                trailing: Text("19:00 PM"),
              ),
              ListTile(
                title: Text("Bila"),
                subtitle: Text("Where are you?.."),
                leading: CircleAvatar(),
                trailing: Text("20:00 PM"),
              )
            ],
          )),
    );
  }
}
