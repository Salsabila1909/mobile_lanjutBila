import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/home_page');
                },
                child: Text("<<Back")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/homepage');
                },
                child: Text("Next >>"))
          ],
        ),
      ),
    );
  }
}
