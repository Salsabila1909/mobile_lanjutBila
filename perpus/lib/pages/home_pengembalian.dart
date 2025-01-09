import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengembalians.dart';
import 'add_pengembalian_page.dart';
import 'detail_pengembalian_page.dart';

class HomePagePengembalian extends StatefulWidget {
  @override
  _HomePagePengembalianState createState() => _HomePagePengembalianState();
}

class _HomePagePengembalianState extends State<HomePagePengembalian> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Pengembalians>(context).initializeData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allPengembalianProvider = Provider.of<Pengembalians>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ALL PENGEMBALIAN"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPengembalian.routeName);
            },
          ),
        ],
      ),
      body: allPengembalianProvider.allPengembalian.isEmpty
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
                      Navigator.pushNamed(context, AddPengembalian.routeName);
                    },
                    child: Text(
                      "Add Pengembalian",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allPengembalianProvider.allPengembalian.length,
              itemBuilder: (context, index) {
                var pengembalian =
                    allPengembalianProvider.allPengembalian[index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailPengembalian.routeName,
                      arguments: pengembalian.id,
                    );
                  },
                  title: Text(
                    "Kode Anggota: ${pengembalian.kodeAnggota}",
                  ),
                  subtitle: Text(
                    "Kode Buku: ${pengembalian.kodeBuku}\nDenda: ${pengembalian.denda}",
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      allPengembalianProvider.deletePengembalian(
                          pengembalian.id,
                          context); // Gantilah dengan pengembalian
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
