import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroments.dart';
import 'package:flutter_chat/models/login_response.dart';
import 'package:flutter_chat/models/user_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _authenticate = false;
  late String _error;

  final _storage = const FlutterSecureStorage();

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

  //Getter del token estaticos

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  final dio = Dio(BaseOptions(
    baseUrl: Enviroments.apiUrl,
  ));

  Future<bool> login(String email, String password) async {
    authenticate = true;
    try {
      final response = await dio.post(
        '/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final loginResponse = loginResponseFromJson(response.data);
      usuario = loginResponse.usuario;
      await saveToken(loginResponse.token);
      authenticate = false;
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Revisar conexión a internet');
      }
      authenticate = false;
      return false;
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> register(String nombre, String email, String password) async {
    authenticate = true;
    try {
      final response = await dio.post(
        '/login/new',
        data: {'nombre': nombre, 'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final loginResponse = loginResponseFromJson(response.data);
      usuario = loginResponse.usuario;
      await saveToken(loginResponse.token);
      authenticate = false;
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Revisar conexión a internet');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';
    print('Token::$token');
    if ( token != '') {
    final response = await dio.get(
      '/login/renew',
      options: Options(
          headers: {'Content-Type': 'application/json', 'x-token': token}),
    );
    print('Tokenresp::$token');
      final loginResponse = loginResponseFromJson(response.data);
      usuario = loginResponse.usuario;
      await saveToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
