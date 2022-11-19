import 'package:flutter/material.dart';
import 'package:inovilage/model/PengirimanModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';

class PengirimanProvider with ChangeNotifier {
  List<PengirimanModel> _listPengiriman = [];
  List<PengirimanModel> get listPengiriman => _listPengiriman;
  bool _loadingList = true;
  bool get loadingList => _loadingList;

  Future<Map<String, dynamic>> getListPengiriman() async {
    _listPengiriman = [];
    _loadingList = true;
    notifyListeners();
    try {
      var response = await EndPoint.getListPengiriman();

      if (response['code'] == '00') {
        _listPengiriman = List<PengirimanModel>.from(
            response['data'].map((e) => PengirimanModel.fromJson(e)).toList());
      } else {
        _listPengiriman = [];
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
      var response = await EndPoint.requestPengiriman(
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
