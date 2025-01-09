import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bukus.dart';

class AddBuku extends StatelessWidget {
  static const routeName = '/add-buku';

  final TextEditingController kodeBukuController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController pengarangController = TextEditingController();
  final TextEditingController tahunTerbitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bukus = Provider.of<Bukus>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Buku"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              bukus
                  .addBuku(
                kodeBukuController.text,
                judulController.text,
                penerbitController.text,
                pengarangController.text,
                tahunTerbitController.text,
              )
                  .then(
                (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Berhasil ditambahkan"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                },
              );
            },
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
                decoration: InputDecoration(
                  labelText: "Kode Buku",
                ),
                textInputAction: TextInputAction.next,
                controller: kodeBukuController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Judul Buku",
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
                  bukus
                      .addBuku(
                    kodeBukuController.text,
                    judulController.text,
                    penerbitController.text,
                    pengarangController.text,
                    tahunTerbitController.text,
                  )
                      .then(
                    (response) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Berhasil ditambahkan"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    bukus
                        .addBuku(
                      kodeBukuController.text,
                      judulController.text,
                      penerbitController.text,
                      pengarangController.text,
                      tahunTerbitController.text,
                    )
                        .then(
                      (response) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Berhasil ditambahkan"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
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
