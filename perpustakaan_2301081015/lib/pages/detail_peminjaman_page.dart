import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/peminjamans.dart'; // Gantilah dengan provider peminjaman Anda

class DetailPeminjaman extends StatelessWidget {
  static const routeName = '/detail-peminjaman';

  @override
  Widget build(BuildContext context) {
    final peminjamans = Provider.of<Peminjamans>(context, listen: false);
    final peminjamanId = ModalRoute.of(context)!.settings.arguments as String;
    final selectPeminjaman = peminjamans.selectById(peminjamanId);

    final TextEditingController kodeAnggotaController =
        TextEditingController(text: selectPeminjaman.kodeAnggota);
    final TextEditingController tglPinjamController =
        TextEditingController(text: selectPeminjaman.tglPinjam);
    final TextEditingController tglKembaliController =
        TextEditingController(text: selectPeminjaman.tglKembali);
    final TextEditingController kodeBukuController =
        TextEditingController(text: selectPeminjaman.kodeBuku);

    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL PEMINJAMAN"),
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
                  labelText: "Tanggal Pinjam",
                ),
                textInputAction: TextInputAction.next,
                controller: tglPinjamController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Tanggal Kembali",
                ),
                textInputAction: TextInputAction.next,
                controller: tglKembaliController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Kode Buku",
                ),
                textInputAction: TextInputAction.done,
                controller: kodeBukuController,
                onEditingComplete: () {
                  peminjamans.editPeminjaman(
                    peminjamanId,
                    kodeAnggotaController.text,
                    tglPinjamController.text,
                    tglKembaliController.text,
                    kodeBukuController.text,
                    context,
                  );
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    peminjamans.editPeminjaman(
                      peminjamanId,
                      kodeAnggotaController.text,
                      tglPinjamController.text,
                      tglKembaliController.text,
                      kodeBukuController.text,
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
