// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inovilage/helper/Pref.dart';

class Network {
  // final String server = "https://inovilage.waserdajaya.store/api/";
  final String server = "https://api.xsamp.com/api/";

  Map<String, String> headers = {'content-type': 'application/json'};
  final String codeError = "-1";
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future get({
    required String url,
    Map<String, String>? params,
    Map<String, String>? header,
  }) async {
    String sendUrl = server + url;
    List<String> keys = [];
    if (params != null) {
      for (var mapEntry in params.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        keys.add("$key=$value");
      }
      String parameter = keys.join('&').toString();
      sendUrl = "$sendUrl?$parameter";
    }

    Map<String, String> sendHeader = {};
    if (header != null) {
      for (final mapEntry in header.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        headers[key] = value;
      }
    }
    var tokenAuth = await Pref.getToken();
    if (tokenAuth.toString().isNotEmpty) {
      headers['Authorization'] = "$tokenAuth";
    }
    headers.addAll(sendHeader);
    http.Response response = await http.get(
      Uri.parse(sendUrl),
      headers: headers,
    );
    return json.decode(response.body);
  }

  Future<void> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    Map<String, String> sendHeader = {};
    Map<String, dynamic> sendBody = {};
    String sendUrl = server + url;
    if (header != null) {
      for (final mapEntry in header.entries) {
        final key = mapEntry.key, value = mapEntry.value;

        headers[key] = value;
      }
      headers.addAll(sendHeader);
    }

    if (body != null) {
      for (final mapEntry in body.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        sendBody[key] = value;
      }
    }

    var tokenAuth = await Pref.getToken();
    if (tokenAuth.toString().isNotEmpty) {
      headers['Authorization'] = "$tokenAuth";
    }
    http.Response response = await http.post(
      Uri.parse(sendUrl),
      body: json.encode(sendBody),
      headers: headers,
    );
    try {
      return json.decode(response.body);
    } catch (e) {
      return json.decode(json.encode({
        "data": response.body,
      }));
    }
  }
}
