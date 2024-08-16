import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models/mensajes_response.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:flutter_chat/services/chat_services.dart';
import 'package:flutter_chat/services/socket_service.dart';
import 'package:flutter_chat/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPages extends StatefulWidget {
  const ChatPages({super.key});

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late ChatServices chatServices;
  late SocketService socketService;
  late AuthService authService;
  final List<ChatMessage> _messages = [];
  bool _estaEscribiendo = false;

  @override
  void initState() {
    super.initState();
    chatServices = Provider.of<ChatServices>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService.socket.on(
      'mensaje-personal',
      (data) => _escucharMensaje(data),
    );
    _cargarHistorial(chatServices.usuarioSelect.uid);
  }

  void _cargarHistorial(String userId) async {
    List<Mensaje> chat = await chatServices.getChat(userId);
    // print(chat);
    final history = chat.map(
      (e) => ChatMessage(
          texto: e.mensage,
          uid: e.from,
          animationController: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 0))
            ..forward()),
    );
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    // print('new message:${payload['mensage']}');
    ChatMessage message = ChatMessage(
        texto: payload['mensage'],
        uid: payload['from'],
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300)));
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioSelected = chatServices.usuarioSelect;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                maxRadius: 15,
                child: Text(
                  usuarioSelected.nombre.substring(0, 2),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                usuarioSelected.nombre,
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
              reverse: true,
            )),
            const Divider(
              height: 1,
            ),
            SizedBox(
              height: 100,
              // color: Colors.amber,
              child: _inputChat(),
            )
          ],
        ));
  }

_inputChat() {
  return SafeArea(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _textController,
                onChanged: (text) {
                  setState(() {
                    _estaEscribiendo = text.isNotEmpty;
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                    child: const Text(
                      'Enviar',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.send,
                      color: _estaEscribiendo ? Colors.blue : Colors.grey,
                    ),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                  ),
          ),
        ],
      ),
    ),
  );
}

  void _handleSubmit(String text) {
    if (text.isEmpty) return;
    // debugPrint('mensaje::$text');
    final newMessage = ChatMessage(
      texto: text,
      uid: authService.usuario.uid,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
    socketService.emit('mensaje-personal', {
      'from': authService.usuario.uid,
      'to': chatServices.usuarioSelect.uid,
      'mensage': text
    });
    // _focusNode.requestFocus();
    _textController.clear();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService.socket.off('mensaje-personal');

    super.dispose();
  }
}
