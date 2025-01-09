import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anggotas.dart';

class AddAnggota extends StatelessWidget {
  static const routeName = '/add-anggota';

  final TextEditingController kodeAnggotaController = TextEditingController();
  final TextEditingController namaAnggotaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final anggotas = Provider.of<Anggotas>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Anggota"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              anggotas
                  .addAnggota(
                kodeAnggotaController.text,
                namaAnggotaController.text,
                alamatController.text,
                jenisKelaminController.text,
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
                  labelText: "Kode Anggota",
                ),
                textInputAction: TextInputAction.next,
                controller: kodeAnggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Nama Anggota",
                ),
                textInputAction: TextInputAction.next,
                controller: namaAnggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Alamat",
                ),
                textInputAction: TextInputAction.next,
                controller: alamatController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Jenis Kelamin (L/P)",
                ),
                textInputAction: TextInputAction.done,
                controller: jenisKelaminController,
                onEditingComplete: () {
                  anggotas
                      .addAnggota(
                    kodeAnggotaController.text,
                    namaAnggotaController.text,
                    alamatController.text,
                    jenisKelaminController.text,
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
                    anggotas
                        .addAnggota(
                      kodeAnggotaController.text,
                      namaAnggotaController.text,
                      alamatController.text,
                      jenisKelaminController.text,
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
