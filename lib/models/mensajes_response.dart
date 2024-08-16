// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) => MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) => json.encode(data.toJson());

class MensajesResponse {
    final bool ok;
    final List<Mensaje> mensajes;

    MensajesResponse({
        required this.ok,
        required this.mensajes,
    });

    factory MensajesResponse.fromJson(Map<String, dynamic> json) => MensajesResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
    };
}

class Mensaje {
    final String from;
    final String to;
    final String mensage;
    final DateTime createdAt;
    final DateTime updatedAt;

    Mensaje({
        required this.from,
        required this.to,
        required this.mensage,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        from: json["from"],
        to: json["to"],
        mensage: json["mensage"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "mensage": mensage,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
