import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroments.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { offline, online, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  io.Socket get socket => _socket;
  get emit => _socket.emit;

  void connect() async {
    final token = await AuthService.getToken();
    debugPrint(token);

    _socket = io.io(
      Enviroments.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .setExtraHeaders({'x-token': token})
          .build(),
    );

    _socket.onConnect((_) {
      debugPrint('Connect');
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      debugPrint('Disconnect');
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    // Aquí puedes añadir otros eventos que quieras escuchar
  }

  void disconnect() {
    _socket.disconnect();
  }
}
