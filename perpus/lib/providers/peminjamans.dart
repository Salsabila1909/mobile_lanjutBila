import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/peminjaman.dart';

class Peminjamans with ChangeNotifier {
  final List<Peminjaman> _allPeminjaman = [];

  List<Peminjaman> get allPeminjaman => _allPeminjaman;

  int get jumlahPeminjaman => _allPeminjaman.length;

  Peminjaman selectById(String id) {
    return _allPeminjaman.firstWhere((element) => element.id == id);
  }

  Future<void> addPeminjaman(
    String kodeAnggota,
    String kodeBuku,
    String tglPinjam,
    String tglKembali,
  ) async {
    Uri url = Uri.parse("http://localhost/perpustakaan/peminjaman.php");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "kodeanggota": kodeAnggota,
          "kodebuku": kodeBuku,
          "tgl_pinjam": tglPinjam,
          "tgl_kembali": tglKembali,
        }),
      );

      print("THEN FUNCTION");
      print(json.decode(response.body));

      final peminjaman = Peminjaman(
        id: json.decode(response.body)["id"],
        kodeAnggota: kodeAnggota,
        kodeBuku: kodeBuku,
        tglPinjam: tglPinjam,
        tglKembali: tglKembali,
      );

      _allPeminjaman.add(peminjaman);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  void editPeminjaman(
    String id,
    String kodeAnggota,
    String kodeBuku,
    String tglPinjam,
    String tglKembali,
    BuildContext context,
  ) {
    Peminjaman selectedPeminjaman =
        _allPeminjaman.firstWhere((element) => element.id == id);
    selectedPeminjaman.kodeAnggota = kodeAnggota;
    selectedPeminjaman.kodeBuku = kodeBuku;
    selectedPeminjaman.tglPinjam = tglPinjam;
    selectedPeminjaman.tglKembali = tglKembali;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  void deletePeminjaman(String id, BuildContext context) {
    _allPeminjaman.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );
    notifyListeners();
  }

  Future<void> initializeData() async {
    Uri url = Uri.parse("http://localhost/perpustakaan/peminjaman.php");
    try {
      var hasilGetData = await http.get(url);
      var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;

      // Create Peminjaman objects from the response data
      final List<Peminjaman> loadedPeminjaman = [];
      dataResponse.forEach((key, value) {
        loadedPeminjaman.add(
          Peminjaman(
            id: value['id'],
            kodeAnggota: value['kodeanggota'],
            kodeBuku: value['kodebuku'],
            tglPinjam: value['tgl_pinjam'],
            tglKembali: value['tgl_kembali'],
          ),
        );
      });

      _allPeminjaman.clear();
      _allPeminjaman.addAll(loadedPeminjaman);

      print("BERHASIL MEMUAT DATA LIST");
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
