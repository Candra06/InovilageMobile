import 'package:flutter/material.dart';
import 'package:inovilage/helper/Pref.dart';
import 'package:inovilage/model/AuthModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthModel _authData = AuthModel();
  AuthModel get authData => _authData;
  Map _dataDashboard = {}, _statusKurir = {};
  Map get dataDashboard => _dataDashboard;
  Map get statusKurir => _statusKurir;

  Future<Map<String, dynamic>> register({
    required Map<String, dynamic> body,
  }) async {
    try {
      var request = await EndPoint.register(
        body: body,
      );
      if (request['code'] == '00') {
        _authData = AuthModel.fromJson(request['data']);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', "Bearer ${request['access_token']}");
      }
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
      if (request['code'] == '00') {
        _authData = AuthModel.fromJson(request['data']);
      }
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

      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> dashboard() async {
    try {
      var request = await EndPoint.dashboard();
      if (request['code'] == '00') {
        _dataDashboard = request['data'];
      }
      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      var request = await EndPoint.logout();

      return request;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }
}
