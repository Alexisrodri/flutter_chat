import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroments.dart';
import 'package:flutter_chat/models/login_response.dart';
import 'package:flutter_chat/models/user_response.dart';

class AuthService with ChangeNotifier {
  final dio = Dio();
  late Usuario usuario;
  bool _authenticate = false;

  bool get authenticate => _authenticate;

  set authenticate(bool value) {
    _authenticate = value;
    notifyListeners();
  }

  Future<Usuario?> login(String email, String password) async {
    authenticate = true;
    try {
      final response = await dio.post(
        '${Enviroments.apiUrl}/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = loginResponseFromJson(response.data);
        usuario = loginResponse.usuario;
        authenticate = false;
        return usuario;
      } else {
        authenticate = false;
        throw Exception('Error al autenticar: Código ${response.statusCode}');
      }
    } on DioException catch (e) {
      authenticate = false;
      // Manejo específico de errores
      if (e.response?.statusCode == 404) {
        throw Exception('Contraseña no es válida');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Token incorrecto');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Revisar conexiones a internet');
      } else {
        throw Exception('Error desconocido: ${e.message}');
      }
    } catch (e) {
      authenticate = false;
      // Loguear cualquier otro error inesperado
      // print('Error inesperado: $e');
      throw Exception('Error inesperado');
    }
  }
}
