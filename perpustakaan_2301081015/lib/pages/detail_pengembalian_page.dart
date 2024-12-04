import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengembalians.dart';

class DetailPengembalian extends StatelessWidget {
  static const routeName = '/detail-pengembalian';

  @override
  Widget build(BuildContext context) {
    final pengembalianId = ModalRoute.of(context)!.settings.arguments as String;
    final pengembalian =
        Provider.of<Pengembalians>(context).selectById(pengembalianId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pengembalian"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Kode Anggota: ${pengembalian.kodeAnggota}"),
            Text("Kode Buku: ${pengembalian.kodeBuku}"),
            Text("Denda: ${pengembalian.denda}"),
          ],
        ),
      ),
    );
  }
}
