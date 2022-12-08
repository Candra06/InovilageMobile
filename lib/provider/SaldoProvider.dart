import 'package:flutter/material.dart';
import 'package:inovilage/model/SaldoModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';

class SaldoProvider with ChangeNotifier {
  bool _loading = true;
  bool get loading => _loading;
  List<SaldoModel> _listSaldo = [];
  List<SaldoModel> get listSaldo => _listSaldo;
  Future<Map<String, dynamic>> getListSaldo() async {
    _loading = true;
    var response = await EndPoint.getSaldo();
    if (response['code'] == '00') {
      _listSaldo = List<SaldoModel>.from(
          response['data'].map((e) => SaldoModel.fromJson(e)).toList());
    } else {
      _listSaldo = [];
    }
    try {
      _loading = false;
      notifyListeners();
      return response;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> withdraw(
    Map<String, dynamic> body,
  ) async {
    try {
      var response = await EndPoint.withdrawSaldo(body);

      return response;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }
}
