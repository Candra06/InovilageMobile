import 'package:flutter/material.dart';
import 'package:inovilage/model/ArtikelModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';

class ArtikelProvider with ChangeNotifier {
  List<ArtikelModel>? _listArtikel;

  List<ArtikelModel> get listArtikel => _listArtikel!;

  Future<Map<String, dynamic>>? getArtikelList() async {
    try {
      var data = await EndPoint.getArtikel();
      if (data['code'] == '00') {
        Map<String, dynamic> hasil = data;
        List res = hasil['data'];

        _listArtikel = res.map((e) => ArtikelModel.fromJson(e)).toList();
        notifyListeners();
      } else {
        _listArtikel = [];
      }
      return data!;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  // Future<Map<String, dynamic>>? postArtikel(
  //     {Map<String, dynamic>? body}) async {
  //   try {
  //     var data = await EndPoint.postAArtikel(body!);
  //     Map hasil = data;

  //     notifyListeners();
  //     if (hasil['status_code'] == 200) {
  //       return {
  //         "status": true,
  //         "message": "Berhasil Login",
  //       };
  //     } else {
  //       return {
  //         "status": false,
  //         "message": "Gagal Login",
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       "status": false,
  //       "message": e.toString(),
  //     };
  //   }
  // }

  // Future<Map<String, dynamic>>? editArtikel(
  //     {String? id, Map<String, dynamic>? body}) async {
  //   try {
  //     var data = await EndPoint.editArtikel(id!, body!);
  //     Map hasil = data;

  //     notifyListeners();
  //     if (hasil['status_code'] == 200) {
  //       return {
  //         "status": true,
  //         "message": "Berhasil Login",
  //       };
  //     } else {
  //       return {
  //         "status": false,
  //         "message": "Gagal Login",
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       "status": false,
  //       "message": e.toString(),
  //     };
  //   }
  // }
}
