import 'package:perpus/pages/add_buku_page.dart';
import 'package:perpus/pages/add_peminjaman_page.dart';
import 'package:perpus/pages/detail_buku_page.dart';
import 'package:perpus/pages/detail_peminjaman_page.dart';
import 'package:perpus/pages/detail_pengembalian_page.dart';
import 'package:perpus/providers/peminjamans.dart';
import 'package:perpus/providers/pengembalians.dart';
import 'package:provider/provider.dart';
import 'package:perpus/pages/add_pengembalian_page.dart';
import 'package:perpus/login_page.dart';
import 'package:perpus/pages/add_anggota_page.dart';
import 'package:perpus/pages/detail_anggota_page.dart';
import 'package:perpus/providers/anggotas.dart';
import 'package:perpus/providers/bukus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Anggotas()),
        ChangeNotifierProvider(create: (context) => Bukus()),
        ChangeNotifierProvider(create: (context) => Peminjamans()),
        ChangeNotifierProvider(create: (context) => Pengembalians()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          AddAnggota.routeName: (context) => AddAnggota(),
          DetailAnggota.routeName: (context) => DetailAnggota(),
          AddBuku.routeName: (context) => AddBuku(),
          DetailBuku.routeName: (context) => DetailBuku(),
          AddPeminjaman.routeName: (context) => AddPeminjaman(),
          DetailPeminjaman.routeName: (context) => DetailPeminjaman(),
          AddPengembalian.routeName: (context) => AddPengembalian(),
          DetailPengembalian.routeName: (context) => DetailPengembalian(),
        },
      ),
    );
  }
}
