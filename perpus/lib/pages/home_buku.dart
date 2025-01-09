import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bukus.dart';
import 'add_buku_page.dart';
import 'detail_buku_page.dart';

class HomePageBuku extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageBuku> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      // Memastikan data buku diinisialisasi hanya sekali
      Provider.of<Bukus>(context, listen: false).initializeData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allBukuProvider = Provider.of<Bukus>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ALL BUKU"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddBuku.routeName);
            },
          ),
        ],
      ),
      body: allBukuProvider.allBuku.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Data",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddBuku.routeName);
                    },
                    child: Text(
                      "Add Buku",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allBukuProvider.allBuku.length,
              itemBuilder: (context, index) {
                var id = allBukuProvider.allBuku[index].id;
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailBuku.routeName,
                      arguments: id,
                    );
                  },
                  title: Text(
                    allBukuProvider.allBuku[index].judul,
                  ),
                  subtitle: Text(
                    "Kode Buku: ${allBukuProvider.allBuku[index].kodeBuku}",
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      allBukuProvider.deleteBuku(id, context);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
