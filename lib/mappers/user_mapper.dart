import 'package:flutter_chat/models/user_response.dart';

class UserMapper {
  static Usuario userJsonToEntity(Map<String, dynamic> json) => Usuario(
      nombre: json['nombre'], email: json['email'], online: json['online'], uid: json['uid']);
}
