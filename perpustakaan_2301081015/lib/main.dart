import 'package:perpustakaan_2301081015/pages/add_buku_page.dart';
import 'package:perpustakaan_2301081015/pages/add_peminjaman_page.dart';
import 'package:perpustakaan_2301081015/pages/detail_buku_page.dart';
import 'package:perpustakaan_2301081015/pages/detail_peminjaman_page.dart';
import 'package:perpustakaan_2301081015/pages/detail_pengembalian_page.dart';
import 'package:perpustakaan_2301081015/providers/peminjamans.dart';
import 'package:perpustakaan_2301081015/providers/pengembalians.dart';
import 'package:provider/provider.dart';
import 'package:perpustakaan_2301081015/pages/add_pengembalian_page.dart';
import 'package:perpustakaan_2301081015/login_page.dart';
import 'package:perpustakaan_2301081015/pages/add_anggota_page.dart';
import 'package:perpustakaan_2301081015/pages/detail_anggota_page.dart';
import 'package:perpustakaan_2301081015/providers/anggotas.dart';
import 'package:perpustakaan_2301081015/providers/bukus.dart';
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
        home: LoginPage(), // Gunakan LoginPage untuk halaman utama
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
