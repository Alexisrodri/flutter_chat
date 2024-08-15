import 'package:dio/dio.dart';
import 'package:flutter_chat/global/enviroments.dart';
import 'package:flutter_chat/models/user_response.dart';
import 'package:flutter_chat/models/usuarios_response.dart';
import 'package:flutter_chat/services/auth_services.dart';

class UsuariosServices {
  Future<List<Usuario>> getUsuario() async {
    final dio = Dio(BaseOptions(
      baseUrl: Enviroments.apiUrl,
    ));
    try {
      final resp = await dio.get('/usuarios',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          }));
      // print('respuestaUsuarios::${resp.data}');
      final usuarioResponse = usuariosResponseFromJson(resp.data);
      return usuarioResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
