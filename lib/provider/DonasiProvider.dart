import 'package:flutter/material.dart';
import 'package:inovilage/model/PengirimanModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';

class DonasiProvider with ChangeNotifier {
  List<PengirimanModel> _listDonasi = [];
  List<PengirimanModel> get listDonasi => _listDonasi;
  bool _loadingList = true;
  bool get loadingList => _loadingList;

  Future<Map<String, dynamic>> getListPengiriman() async {
    _listDonasi = [];
    _loadingList = true;
    notifyListeners();
    try {
      var response = await EndPoint.getListdonasi();

      if (response['code'] == '00') {
        _listDonasi = List<PengirimanModel>.from(
            response['data'].map((e) => PengirimanModel.fromJson(e)).toList());
      } else {
        _listDonasi = [];
      }
      _loadingList = false;
      notifyListeners();
      return response;
    } catch (e) {
      _loadingList = false;
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> requestPengiriman(
    Map<String, dynamic> body,
  ) async {
    try {
      var response = await EndPoint.requestdonasi(
        body,
      );

      return response;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }
}
