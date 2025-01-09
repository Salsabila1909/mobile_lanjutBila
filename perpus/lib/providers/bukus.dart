import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/buku.dart';

class Bukus with ChangeNotifier {
  final List<Buku> _allBuku = [];

  List<Buku> get allBuku => _allBuku;

  int get jumlahBuku => _allBuku.length;

  Buku selectById(String id) {
    return _allBuku.firstWhere((element) => element.id == id);
  }

  Future<void> addBuku(
    String kodeBuku,
    String judul,
    String penerbit,
    String pengarang,
    String tahunTerbit,
  ) async {
    Uri url = Uri.parse("http://localhost/perpustakaan_bila/buku.php/buku");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "kode_buku": kodeBuku,
          "judul": judul,
          "penerbit": penerbit,
          "pengarang": pengarang,
          "tahun_terbit": tahunTerbit,
        }),
      );

      print("THEN FUNCTION");
      print(json.decode(response.body));

      final buku = Buku(
        id: json.decode(response.body)["id"],
        kodeBuku: kodeBuku,
        judul: judul,
        penerbit: penerbit,
        pengarang: pengarang,
        tahunTerbit: tahunTerbit,
      );

      _allBuku.add(buku);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  void editBuku(
    String id,
    String kodeBuku,
    String judul,
    String penerbit,
    String pengarang,
    String tahunTerbit,
    BuildContext context,
  ) {
    Buku selectedBuku = _allBuku.firstWhere((element) => element.id == id);
    selectedBuku.kodeBuku = kodeBuku;
    selectedBuku.judul = judul;
    selectedBuku.penerbit = penerbit;
    selectedBuku.pengarang = pengarang;
    selectedBuku.tahunTerbit = tahunTerbit;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  void deleteBuku(String id, BuildContext context) {
    _allBuku.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );
    notifyListeners();
  }

  Future<void> initializeData() async {
    Uri url = Uri.parse("http://localhost/perpustakaan_bila/buku.php/buku");
    try {
      var hasilGetData = await http.get(url);
      var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;

      // Create Buku objects from the response data
      final List<Buku> loadedBuku = [];
      dataResponse.forEach((key, value) {
        loadedBuku.add(
          Buku(
            id: value['id'],
            kodeBuku: value['kode_buku'],
            judul: value['judul'],
            penerbit: value['penerbit'],
            pengarang: value['pengarang'],
            tahunTerbit: value['tahun_terbit'],
          ),
        );
      });

      _allBuku.clear();
      _allBuku.addAll(loadedBuku);

      print("BERHASIL MEMUAT DATA LIST");
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
