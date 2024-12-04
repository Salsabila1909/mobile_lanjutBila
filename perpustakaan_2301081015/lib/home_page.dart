import 'package:flutter/material.dart';
import 'package:perpustakaan_2301081015/pages/home_pengembalian.dart';
import 'package:perpustakaan_2301081015/pages/home_anggota.dart';
import 'package:perpustakaan_2301081015/pages/home_buku.dart';
import 'package:perpustakaan_2301081015/pages/home_peminjaman.dart';
//import 'package:flutter_pustaka2301081015/login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Menu"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 163, 238),
              ),
              child: Text(
                'Menu Utama',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Anggota'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeAnggota()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Buku'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeBuku()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Peminjaman'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePeminjaman()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_return), // Ubah ikon
              title: Text('Pengembalian'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePengembalian()),
                );
              },
            ),
            Divider(), // Garis pemisah sebelum Logout
            // ListTile(
            //   leading: Icon(Icons.logout),
            //   title: Text('Logout'),
            //   onTap: () {
            //     // Logout dan kembali ke halaman Login
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => LoginPage()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Pilih Menu dari Drawer untuk Melihat Data',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
