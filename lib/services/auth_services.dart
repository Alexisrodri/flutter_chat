import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroments.dart';
import 'package:flutter_chat/mappers/user_mapper.dart';
import 'package:flutter_chat/models/user_response.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _authenticate = false;
  late String _error;

  bool get authenticate => _authenticate;
  String get error => _error;

  set authenticate(bool value) {
    _authenticate = value;
    notifyListeners();
  }

  set error(String value) {
    _error = value;
    notifyListeners();
  }

  final dio = Dio(BaseOptions(
    baseUrl: Enviroments.apiUrl,
  ));

  Future<Usuario> login(String email, String password) async {
    authenticate = true;

    try {
      final response = await dio.post(
        '/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final loginResponse = UserMapper.userJsonToEntity(response.data);
      usuario = loginResponse;
      print(response.data);
      authenticate = false;
      return usuario;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
