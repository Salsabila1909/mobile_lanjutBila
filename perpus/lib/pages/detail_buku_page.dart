import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bukus.dart';

class DetailBuku extends StatelessWidget {
  static const routeName = '/detail-buku';

  @override
  Widget build(BuildContext context) {
    final bukus = Provider.of<Bukus>(context, listen: false);
    final bukuId = ModalRoute.of(context)!.settings.arguments as String;
    final selectBuku = bukus.selectById(bukuId);

    final TextEditingController kodeBukuController =
        TextEditingController(text: selectBuku.kodeBuku);
    final TextEditingController judulController =
        TextEditingController(text: selectBuku.judul);
    final TextEditingController penerbitController =
        TextEditingController(text: selectBuku.penerbit);
    final TextEditingController pengarangController =
        TextEditingController(text: selectBuku.pengarang);
    final TextEditingController tahunTerbitController =
        TextEditingController(text: selectBuku.tahunTerbit);

    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL BUKU"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Kode Buku",
                ),
                textInputAction: TextInputAction.next,
                controller: kodeBukuController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Judul",
                ),
                textInputAction: TextInputAction.next,
                controller: judulController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Penerbit",
                ),
                textInputAction: TextInputAction.next,
                controller: penerbitController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Pengarang",
                ),
                textInputAction: TextInputAction.next,
                controller: pengarangController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Tahun Terbit",
                ),
                textInputAction: TextInputAction.done,
                controller: tahunTerbitController,
                onEditingComplete: () {
                  bukus.editBuku(
                    bukuId,
                    kodeBukuController.text,
                    judulController.text,
                    penerbitController.text,
                    pengarangController.text,
                    tahunTerbitController.text,
                    context,
                  );
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    bukus.editBuku(
                      bukuId,
                      kodeBukuController.text,
                      judulController.text,
                      penerbitController.text,
                      pengarangController.text,
                      tahunTerbitController.text,
                      context,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    "EDIT",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
