import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/peminjamans.dart';

class AddPeminjaman extends StatelessWidget {
  static const routeName = '/add-peminjaman';

  final TextEditingController kodeAnggotaController = TextEditingController();
  final TextEditingController kodeBukuController = TextEditingController();
  final TextEditingController tglPinjamController = TextEditingController();
  final TextEditingController tglKembaliController = TextEditingController();

  void _submitForm(BuildContext context) {
    final peminjamans = Provider.of<Peminjamans>(context, listen: false);

    if (kodeAnggotaController.text.isEmpty ||
        kodeBukuController.text.isEmpty ||
        tglPinjamController.text.isEmpty ||
        tglKembaliController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Semua field harus diisi"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    peminjamans
        .addPeminjaman(
      kodeAnggotaController.text,
      kodeBukuController.text,
      tglPinjamController.text,
      tglKembaliController.text,
    )
        .then((response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil ditambahkan"),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
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
        title: Text("Tambah Peminjaman"),
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
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(labelText: "Kode Anggota"),
                textInputAction: TextInputAction.next,
                controller: kodeAnggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Kode Buku"),
                textInputAction: TextInputAction.next,
                controller: kodeBukuController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Tanggal Pinjam"),
                textInputAction: TextInputAction.next,
                controller: tglPinjamController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Tanggal Kembali"),
                textInputAction: TextInputAction.done,
                controller: tglKembaliController,
              ),
              SizedBox(height: 20),
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
