import 'package:flutter/material.dart';
import 'package:inovilage/model/ArtikelModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';

class ArtikelProvider with ChangeNotifier {
  List<ArtikelModel>? _listArtikel;
  ArtikelModel? _detailArtikel;
  bool _loading = true;
  bool get loading => _loading;
  List<ArtikelModel> get listArtikel => _listArtikel!;
  ArtikelModel get detailArtikel => _detailArtikel!;

  Future<Map<String, dynamic>> getArtikelList() async {
    _loading = true;
    _listArtikel = [];
    notifyListeners();
    try {
      var data = await EndPoint.getArtikel();
      if (data['code'] == '00') {
        Map<String, dynamic> hasil = data;
        List res = hasil['data'];

        _listArtikel = res.map((e) => ArtikelModel.fromJson(e)).toList();
      } else {
        _listArtikel = [];
      }
      _loading = false;
      notifyListeners();
      return data!;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getDetailArtikel(String id) async {
    try {
      var data = await EndPoint.getDetailArtikel(id);
      if (data['code'] == '00') {
        Map<String, dynamic> hasil = data['data'];

        _detailArtikel = ArtikelModel.fromJson(hasil);
      } else {
        _listArtikel = [];
      }
      _loading = false;
      notifyListeners();
      return data;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> postArtikel(
      {required Map<String, dynamic> body}) async {
    try {
      var data = await EndPoint.postArtikel(
        body: body,
      );

      return data;
    } catch (e) {
      return {
        "status": false,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> editArtikel(
      {required String id, required Map<String, dynamic> body}) async {
    try {
      var data = await EndPoint.editArtikel(
        id: id,
        body: body,
      );
      return data;
    } catch (e) {
      return {
        "status": false,
        "message": e.toString(),
      };
    }
  }
}
