import 'package:flutter/material.dart';
import 'package:inovilage/model/AuthModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthModel? _authData;
  AuthModel? get authData => _authData!;
  Map _dataDashboard = {}, _statusKurir = {};
  Map get dataDashboard => _dataDashboard;
  Map get statusKurir => _statusKurir;
  bool _loading = false;
  bool get loading => _loading;
  List<AuthModel> _listKurir = [], _listPengguna = [], _listUsers = [];
  List<AuthModel> get listKurir => _listKurir;
  List<AuthModel> get listPengguna => _listPengguna;
  List<AuthModel> get listUsers => _listUsers;

  Future<Map<String, dynamic>> register({
    required Map<String, dynamic> body,
    bool saveData = false,
  }) async {
    try {
      var request = await EndPoint.register(
        body: body,
      );
      if (request['code'] == '00') {
        if (saveData) {
          _authData = AuthModel.fromJson(request['data']);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('token', "Bearer ${request['access_token']}");
        }
      }
      notifyListeners();
      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> login({
    required Map<String, dynamic> body,
  }) async {
    try {
      var request = await EndPoint.login(
        body: body,
      );
      if (request['code'] == '00') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', "Bearer ${request['access_token']}");
      }

      notifyListeners();
      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    try {
      var request = await EndPoint.getUserData();
      print(request);
      if (request['code'] == '00') {
        _authData = AuthModel.fromJson(request['data']);
      }

      notifyListeners();
      return request;
    } catch (e) {
      print(e);
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getStatusKurir() async {
    try {
      var request = await EndPoint.getstatusKurir();
      if (request['code'] == '00') {
        _statusKurir = request['data'];
      }

      notifyListeners();
      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> updateProfil({
    required Map<String, dynamic> body,
  }) async {
    try {
      var request = await EndPoint.updateProfil(
        body: body,
      );

      notifyListeners();
      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> updateStatusKurir({
    required Map<String, dynamic> body,
  }) async {
    try {
      var request = await EndPoint.updateStatusKurir(
        body: body,
      );
      if (request['code'] == '00') {
        _statusKurir = request['data'];
      }

      notifyListeners();
      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> listUser() async {
    _listKurir = [];
    _listPengguna = [];
    _listUsers = [];
    notifyListeners();
    try {
      AuthModel tmpData;
      var request = await EndPoint.getListUser();
      if (request['code'] == '00') {
        _listUsers = List<AuthModel>.from(
            request['data'].map((e) => AuthModel.fromJson(e)).toList());
        for (var element in request['data']) {
          if (element['role'] == 'Kurir') {
            tmpData = AuthModel.fromJson(element);
            _listKurir.add(tmpData);
          } else if (element['role'] == 'Pengguna') {
            tmpData = AuthModel.fromJson(element);
            _listPengguna.add(tmpData);
          }
        }
      }
      notifyListeners();
      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> dashboard() async {
    _loading = true;
    notifyListeners();
    try {
      var request = await EndPoint.dashboard();

      if (request['code'] == '00') {
        _dataDashboard = request['data'];
      }
      _loading = false;
      notifyListeners();
      return request;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      var request = await EndPoint.logout();
      if (request['code'] == '00') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', "");
      }
      notifyListeners();
      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }
}
