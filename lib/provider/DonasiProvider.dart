import 'package:flutter/material.dart';
import 'package:inovilage/model/DetailPengirimanModel.dart';
import 'package:inovilage/model/PengirimanModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';

class DonasiProvider with ChangeNotifier {
  List<PengirimanModel> _listDonasi = [];
  List<PengirimanModel> get listDonasi => _listDonasi;
  bool _loadingList = true;
  bool get loadingList => _loadingList;
  DetailPengirimanModel? _detailDonasi;
  DetailPengirimanModel get detailDonasi => _detailDonasi!;
  List _listItem = [];
  List get listItem => _listItem;
  Map _totalOrganik = {
        "volume": 0,
      },
      _totalAnorganik = {
        "volume": 0,
      };
  Map get totalOrganik => _totalOrganik;
  Map get totalAnorganik => _totalAnorganik;

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

  Future<Map<String, dynamic>> getDetailPengiriman(String id) async {
    try {
      var response = await EndPoint.getDetaildonasi(id);
      if (response['code'] == '00') {
        _detailDonasi = DetailPengirimanModel.fromJson(response['data']);
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
        };
        _totalAnorganik = {
          "volume": 0,
        };
      } else {
        _listItem.add(item);
        if (item['jenis'] == 'Organik') {
          _totalOrganik['volume'] =
              double.parse(_totalOrganik['volume'].toString()) +
                  double.parse(item['volume'].toString());
        } else {
          _totalAnorganik['volume'] =
              double.parse(_totalAnorganik['volume'].toString()) +
                  double.parse(item['volume'].toString());
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
      var response = await EndPoint.addItemdonasi(
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
      var response = await EndPoint.confirmdonasi(
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
