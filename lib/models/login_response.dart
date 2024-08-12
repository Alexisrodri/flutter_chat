
import 'dart:convert';

import 'package:flutter_chat/models/user_response.dart';


LoginResponse loginResponseFromJson(Map<String, dynamic> json) => LoginResponse.fromJson(json);

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    final bool ok;
    final Usuario usuario;
    final String token;

    LoginResponse({
        required this.ok,
        required this.usuario,
        required this.token,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuarioDB"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
    };
}
