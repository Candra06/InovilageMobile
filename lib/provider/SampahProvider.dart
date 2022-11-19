import 'package:flutter/material.dart';
import 'package:inovilage/model/TrashModel.dart';
import 'package:inovilage/network/EndPoint.dart';
import 'package:inovilage/network/Network.dart';

class SampahProvider with ChangeNotifier {
  List<TrashModel>? _listTrash;
  List<TrashModel> get listTrash => _listTrash!;

  Future<Map<String, dynamic>> getListTrash() async {
    var response = await EndPoint.getListSampah();
    try {
      if (response['code'] == '00') {
        _listTrash = List<TrashModel>.from(
            response['data'].map((e) => TrashModel.fromJson(e)).toList());
      } else {
        _listTrash = [];
      }
      return response;
    } catch (e) {
      return {
        "code": Network().codeError,
        "message": e.toString(),
      };
    }
  }
}
