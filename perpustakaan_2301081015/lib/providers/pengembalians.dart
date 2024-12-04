import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/pengembalian.dart';

class Pengembalians with ChangeNotifier {
  final List<Pengembalian> _allPengembalian = [];

  List<Pengembalian> get allPengembalian => _allPengembalian;

  int get jumlahPengembalian => _allPengembalian.length;

  Pengembalian selectById(String id) {
    return _allPengembalian.firstWhere((element) => element.id == id);
  }

  Future<void> addPengembalian(
    String kodeAnggota,
    double denda,
    String kodeBuku,
  ) async {
    Uri url = Uri.parse(
        "http://localhost/perpustakaan/pengembalian.php/pengembalian");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "kodeanggota": kodeAnggota,
          "denda": denda,
          "kodebuku": kodeBuku,
        }),
      );

      final pengembalian = Pengembalian(
        id: json.decode(response.body)["id"],
        kodeAnggota: kodeAnggota,
        denda: denda,
        kodeBuku: kodeBuku,
      );

      _allPengembalian.add(pengembalian);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  void deletePengembalian(String id, BuildContext context) {
    _allPengembalian.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Pengembalian berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );
    notifyListeners();
  }

  Future<void> initializeData() async {
    Uri url = Uri.parse(
        "http://localhost/perpustakaan/pengembalian.php/pengembalian");
    try {
      var hasilGetData = await http.get(url);
      var dataResponse = json.decode(hasilGetData.body) as List<dynamic>;

      final List<Pengembalian> loadedPengembalian = [];
      dataResponse.forEach((value) {
        loadedPengembalian.add(
          Pengembalian(
            id: value['id'],
            kodeAnggota: value['kodeanggota'],
            denda: value['denda'],
            kodeBuku: value['kodebuku'],
          ),
        );
      });

      _allPengembalian.clear();
      _allPengembalian.addAll(loadedPengembalian);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
