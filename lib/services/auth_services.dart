import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroments.dart';
import 'package:flutter_chat/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat/models/user_response.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _authenticate = false;

  bool get autenticate => _authenticate;

  set autenticate(bool value) {
    _authenticate = value;
    notifyListeners();
  }

  Future login(String email, String password) async {
    autenticate = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    // if(resp)

    debugPrint(resp.body);
    // debugPrint(resp.statusCode.toString());

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
    }
    autenticate = false;
  }
}
