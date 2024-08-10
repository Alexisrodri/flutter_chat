import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroments.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Future login(String email, String password) async {
    final data = {'email': email, 'password': password};
    final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    debugPrint(resp.body);
  }
}
