import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/anggota.dart';

class Anggotas with ChangeNotifier {
  final List<Anggota> _allAnggota = [];

  List<Anggota> get allAnggota => _allAnggota;

  int get jumlahAnggota => _allAnggota.length;

  Anggota selectById(String id) {
    return _allAnggota.firstWhere((element) => element.id == id);
  }

  Future<void> addAnggota(
    String kodeAnggota,
    String namaAnggota,
    String alamat,
    String jenisKelamin,
  ) async {
    Uri url =
        Uri.parse("http://localhost/perpustakaan_bila/anggota.php/anggota");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "kode_anggota": kodeAnggota,
          "nama_anggota": namaAnggota,
          "alamat": alamat,
          "jenis_kelamin": jenisKelamin,
        }),
      );

      print("THEN FUNCTION");
      print(json.decode(response.body));

      final anggota = Anggota(
        id: json.decode(response.body)["id"],
        kodeAnggota: kodeAnggota,
        namaAnggota: namaAnggota,
        alamat: alamat,
        jenisKelamin: jenisKelamin,
      );

      _allAnggota.add(anggota);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  void editAnggota(
    String id,
    String kodeAnggota,
    String namaAnggota,
    String alamat,
    String jenisKelamin,
    BuildContext context,
  ) {
    Anggota selectedAnggota =
        _allAnggota.firstWhere((element) => element.id == id);
    selectedAnggota.kodeAnggota = kodeAnggota;
    selectedAnggota.namaAnggota = namaAnggota;
    selectedAnggota.alamat = alamat;
    selectedAnggota.jenisKelamin = jenisKelamin;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  void deleteAnggota(String id, BuildContext context) {
    _allAnggota.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );
    notifyListeners();
  }

  Future<void> initializeData() async {
    Uri url =
        Uri.parse("http://localhost/perpustakaan_bila/anggota.php/anggota");
    try {
      var hasilGetData = await http.get(url);
      var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;

      // Create Anggota objects from the response data
      final List<Anggota> loadedAnggota = [];
      dataResponse.forEach((key, value) {
        loadedAnggota.add(
          Anggota(
            id: value['id'],
            kodeAnggota: value['kode_anggota'],
            namaAnggota: value['nama_anggota'],
            alamat: value['alamat'],
            jenisKelamin: value['jenis_kelamin'],
          ),
        );
      });

      _allAnggota.clear();
      _allAnggota.addAll(loadedAnggota);

      print("BERHASIL MEMUAT DATA LIST");
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
