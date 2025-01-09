import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/peminjamans.dart';
import 'add_peminjaman_page.dart';
import 'detail_peminjaman_page.dart';

class HomePagePeminjaman extends StatefulWidget {
  @override
  _HomePagePeminjamanState createState() => _HomePagePeminjamanState();
}

class _HomePagePeminjamanState extends State<HomePagePeminjaman> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Peminjamans>(context).initializeData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allPeminjamanProvider = Provider.of<Peminjamans>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ALL PEMINJAMAN"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPeminjaman.routeName);
            },
          ),
        ],
      ),
      body: allPeminjamanProvider.allPeminjaman.isEmpty
          ? Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Data",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddPeminjaman.routeName);
                    },
                    child: Text(
                      "Add Peminjaman",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allPeminjamanProvider
                  .allPeminjaman.length, // Gantilah dengan peminjaman
              itemBuilder: (context, index) {
                var peminjaman = allPeminjamanProvider
                    .allPeminjaman[index]; // Gantilah dengan peminjaman
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailPeminjaman
                          .routeName, // Gantilah dengan route detail peminjaman
                      arguments: peminjaman.id, // Gantilah dengan id peminjaman
                    );
                  },
                  title: Text(
                    "Kode Anggota: ${peminjaman.kodeAnggota}", // Gantilah dengan kode anggota peminjaman
                  ),
                  subtitle: Text(
                    "Kode Buku: ${peminjaman.kodeBuku}\nTanggal Pinjam: ${peminjaman.tglPinjam} - Tanggal Kembali: ${peminjaman.tglKembali}", // Gantilah dengan tanggal peminjaman
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      allPeminjamanProvider.deletePeminjaman(
                          peminjaman.id, context); // Gantilah dengan peminjaman
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
