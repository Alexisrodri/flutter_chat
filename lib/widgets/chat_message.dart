import 'package:flutter/material.dart';
import 'package:flutter_chat/models/user_response.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    super.key, 
    required this.texto, 
    required this.uid, 
    required this.animationController,
    });

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthService>(context,listen: false).usuario;
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == usuario.uid ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 10),
        decoration: BoxDecoration(
          color: const Color(0xff4d9ef6),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, right: 50, left: 10),
        decoration: BoxDecoration(
          color: const Color(0xffe4e5e8),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
