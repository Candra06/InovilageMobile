import 'package:flutter/material.dart';
import 'package:inovilage/model/AuthModel.dart';

class AuthProvider with ChangeNotifier {
  AuthModel _authData = AuthModel();
  AuthModel get authData => _authData;
}
