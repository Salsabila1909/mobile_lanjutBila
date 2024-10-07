import 'package:flutter/material.dart';

void main() {
  runApp(KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KalkulatorHomePage(),
    );
  }
}

class KalkulatorHomePage extends StatefulWidget {
  @override
  _KalkulatorHomePageState createState() => _KalkulatorHomePageState();
}

class _KalkulatorHomePageState extends State<KalkulatorHomePage> {
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();
  String _hasil = "";

  void _hitung(String operasi) {
    double angka1 = double.tryParse(_angka1Controller.text) ?? 0;
    double angka2 = double.tryParse(_angka2Controller.text) ?? 0;
    double hasil = 0;

    switch (operasi) {
      case '+':
        hasil = angka1 + angka2;
        break;
      case '-':
        hasil = angka1 - angka2;
        break;
      case '*':
        hasil = angka1 * angka2;
        break;
      case '/':
        if (angka2 != 0) {
          hasil = angka1 / angka2;
        } else {
          _hasil = "Tidak dapat dibagi dengan nol";
          setState(() {});
          return;
        }
        break;
    }

    _hasil = hasil.toString();
    setState(() {});
  }

  Widget _buildButton(String operasi) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: () => _hitung(operasi),
        child: Text(
          operasi,
          style: TextStyle(fontSize: 18.0),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: TextField(
                controller: _angka1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Angka 1',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            SizedBox(
              width: 150,
              child: TextField(
                controller: _angka2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Angka 2',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton('+'),
                SizedBox(width: 4), // Jarak antara tombol
                _buildButton('-'),
                SizedBox(width: 4), // Jarak antara tombol
                _buildButton('*'),
                SizedBox(width: 4), // Jarak antara tombol
                _buildButton('/'),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'Hasil: $_hasil',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
