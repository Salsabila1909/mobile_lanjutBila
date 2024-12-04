import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengembalians.dart'; // Pastikan import provider Pengembalians

class AddPengembalian extends StatelessWidget {
  static const routeName = '/add-pengembalian';

  final TextEditingController kodeAnggotaController = TextEditingController();
  final TextEditingController kodeBukuController = TextEditingController();
  final TextEditingController dendaController =
      TextEditingController(); // Menambahkan controller untuk denda

  void _submitForm(BuildContext context) {
    final pengembalians = Provider.of<Pengembalians>(context, listen: false);

    // Validasi form untuk memastikan semua field terisi
    if (kodeAnggotaController.text.isEmpty ||
        kodeBukuController.text.isEmpty ||
        dendaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Semua field harus diisi"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Konversi denda menjadi double
    double? denda = double.tryParse(dendaController.text);

    if (denda == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Masukkan jumlah denda yang valid"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Memanggil method untuk menambahkan pengembalian
    pengembalians
        .addPengembalian(
      kodeAnggotaController.text,
      denda,
      kodeBukuController.text,
    )
        .then((response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Pengembalian berhasil ditambahkan"),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan: $error"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Pengembalian"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _submitForm(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              // Input untuk Kode Anggota
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(labelText: "Kode Anggota"),
                textInputAction: TextInputAction.next,
                controller: kodeAnggotaController,
              ),
              // Input untuk Kode Buku
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Kode Buku"),
                textInputAction: TextInputAction.next,
                controller: kodeBukuController,
              ),
              // Input untuk Denda
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Denda"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                controller: dendaController,
              ),
              SizedBox(height: 20),
              // Tombol Submit
              Center(
                child: ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
