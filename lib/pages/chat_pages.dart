import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/widgets/chat_message.dart';

class ChatPages extends StatefulWidget {
  const ChatPages({super.key});

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [
    const ChatMessage(texto: 'Hello world', uid: '123'),
    const ChatMessage(texto: 'Good', uid: '123'),
    const ChatMessage(texto: 'Nice bro', uid: '122'),
    const ChatMessage(texto: 'Nice', uid: '123'),
    const ChatMessage(texto: 'Nice dick', uid: '121'),
    const ChatMessage(texto: 'Nice', uid: '123'),
    const ChatMessage(texto: 'Bro', uid: '122'),
  ];
  bool _estaEscribiendo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                maxRadius: 15,
                child: const Text(
                  'TE',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text(
                'Test Prueba',
                style: TextStyle(color: Colors.black87, fontSize: 12),
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
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
          ),
        ));
  }

  _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String text) {
              setState(() {
                if (text.isNotEmpty) {
                  _estaEscribiendo = true;
                } else {
                  _estaEscribiendo = false;
                }
              });
            },
            decoration: const InputDecoration.collapsed(
              hintText: 'Enviar mensaje',
            ),
            focusNode: _focusNode,
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                    child: const Text('.'),
                  )
                : IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: _estaEscribiendo
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                        // color:,
                        icon: const Icon(
                          Icons.send_rounded,
                        )),
                  ),
          )
        ],
      ),
    ));
  }

  void _handleSubmit(String text) {
    if (text.isEmpty) return;
    debugPrint('mensaje::$text');
    final newMessage = ChatMessage(texto: text, uid: '123');
    _messages.insert(0, newMessage); 
    setState(() {
      _estaEscribiendo = false;
    });
    _focusNode.requestFocus();
    _textController.clear();
  }
}
