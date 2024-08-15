// To parse this JSON data, do
//
//     final usuariosResponse = usuariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_chat/models/user_response.dart';

UsuariosResponse usuariosResponseFromJson(Map<String, dynamic> json) => UsuariosResponse.fromJson(json);

String usuariosResponseToJson(UsuariosResponse data) => json.encode(data.toJson());

class UsuariosResponse {
    final bool ok;
    final List<Usuario> usuarios;

    UsuariosResponse({
        required this.ok,
        required this.usuarios,
    });

    factory UsuariosResponse.fromJson(Map<String, dynamic> json) => UsuariosResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}
