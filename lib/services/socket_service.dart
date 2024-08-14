// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { offline, online, coonnecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.coonnecting;
  // io.Socket _socket; no se pudo inicializar la solucion fue inicializar la variable privada
  // Globalmente fuera de la funcion _initConfig;
  // Local: http://localhost||Ip del dispositivo:3000||puerto del server

  final io.Socket _socket = io.io('https://socket-io-bands.onrender.com/',
      io.OptionBuilder().setTransports(['websocket']).build());

  ServerStatus get serverStatus => _serverStatus;
  io.Socket get socket => _socket;
  get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
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

    // socket.on('nuevo-mensaje', (payload) {
    //   //Recibir payload:String
    //   // debugPrint('nuevo-Mensaje:: $payload');

    //   //Recibir payload:Objeto-Map

    //   debugPrint('nuevo-Mensaje');
    //   debugPrint('nombre:  ${payload['nombre']}');
    //   debugPrint('mensaje: ${payload['mensaje']}');

    //   //En caso de no recibir un dato la app se "Cae" se debe de controlar esos errores.
    //   // debugPrint('mensaje2: ${payload['mensaje2']}');

    //   //Se debe de controlar si se recibe o no ese dato containsKey verifica si existe esa key
    //   debugPrint(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'No found');

    // });
  }
}