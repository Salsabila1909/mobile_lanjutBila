import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anggotas.dart';

class DetailAnggota extends StatelessWidget {
  static const routeName = '/detail-anggota';

  @override
  Widget build(BuildContext context) {
    final anggotas = Provider.of<Anggotas>(context, listen: false);
    final anggotaId = ModalRoute.of(context)!.settings.arguments as String;
    final selectAnggota = anggotas.selectById(anggotaId);

    final TextEditingController kodeAnggotaController =
        TextEditingController(text: selectAnggota.kodeAnggota);
    final TextEditingController namaAnggotaController =
        TextEditingController(text: selectAnggota.namaAnggota);
    final TextEditingController alamatController =
        TextEditingController(text: selectAnggota.alamat);
    final TextEditingController jenisKelaminController =
        TextEditingController(text: selectAnggota.jenisKelamin);

    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL ANGGOTA"),
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
                  anggotas.editAnggota(
                    anggotaId,
                    kodeAnggotaController.text,
                    namaAnggotaController.text,
                    alamatController.text,
                    jenisKelaminController.text,
                    context,
                  );
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    anggotas.editAnggota(
                      anggotaId,
                      kodeAnggotaController.text,
                      namaAnggotaController.text,
                      alamatController.text,
                      jenisKelaminController.text,
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
