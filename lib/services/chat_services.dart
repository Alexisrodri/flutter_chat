import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models/mensajes_response.dart';
import 'package:flutter_chat/models/user_response.dart';
import 'package:flutter_chat/services/auth_services.dart';

import '../global/enviroments.dart';

class ChatServices with ChangeNotifier {
  late Usuario usuarioSelect;

  final dio = Dio(BaseOptions(
    baseUrl: Enviroments.apiUrl,
  ));

  Future<List<Mensaje>> getChat(String userId) async {
    final resp = await dio.get('/mensajes/$userId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        }));
    final mensajesResp = MensajesResponse.fromJson(resp.data);
    return mensajesResp.mensajes;
  }
}
