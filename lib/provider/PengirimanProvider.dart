import 'package:flutter/material.dart';
import 'package:inovilage/model/DetailPengirimanModel.dart';
import 'package:inovilage/model/PengirimanModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';

class PengirimanProvider with ChangeNotifier {
  List<PengirimanModel> _listPengiriman = [];
  List<PengirimanModel> get listPengiriman => _listPengiriman;
  bool _loadingList = true;
  bool get loadingList => _loadingList;
  DetailPengirimanModel? _detailPengiriman;
  DetailPengirimanModel get detailPengiriman => _detailPengiriman!;
  List _listItem = [];
  List get listItem => _listItem;
  Map _totalOrganik = {
        "volume": 0,
        "price": 0,
      },
      _totalAnorganik = {
        "volume": 0,
        "price": 0,
      };
  Map get totalOrganik => _totalOrganik;
  Map get totalAnorganik => _totalAnorganik;

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

  Future<Map<String, dynamic>> getDetailPengiriman(String id) async {
    try {
      var response = await EndPoint.getDetailPengiriman(id);
      if (response['code'] == '00') {
        _detailPengiriman = DetailPengirimanModel.fromJson(response['data']);
      }

      notifyListeners();
      return response;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<bool> addItemTrash({
    required Map<String, dynamic> item,
    bool isReset = false,
  }) async {
    try {
      if (isReset) {
        _listItem = [];
        _totalOrganik = {
          "volume": 0,
          "price": 0,
        };
        _totalAnorganik = {
          "volume": 0,
          "price": 0,
        };
      } else {
        _listItem.add(item);
        if (item['jenis'] == 'Organik') {
          _totalOrganik['volume'] =
              double.parse(_totalOrganik['volume'].toString()) +
                  double.parse(item['volume'].toString());
          _totalOrganik['price'] =
              double.parse(_totalOrganik['price'].toString()) +
                  double.parse(item['subtotal'].toString());
        } else {
          _totalAnorganik['volume'] =
              double.parse(_totalAnorganik['volume'].toString()) +
                  double.parse(item['volume'].toString());
          _totalAnorganik['price'] =
              double.parse(_totalAnorganik['price'].toString()) +
                  double.parse(item['subtotal'].toString());
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> addItemPengiriman(
      Map<String, dynamic> body, String id) async {
    try {
      var response = await EndPoint.addItemPengiriman(
        body,
        id,
      );

      return response;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> confirm(
    String id,
  ) async {
    try {
      var response = await EndPoint.confirmPengiriman(
        id,
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
