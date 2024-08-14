import 'package:flutter/material.dart';
import 'package:flutter_chat/models/usuario.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:flutter_chat/services/socket_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPages extends StatefulWidget {
  const UsersPages({super.key});

  @override
  State<UsersPages> createState() => _UsersPagesState();
}

class _UsersPagesState extends State<UsersPages> {
  final usuarios = [
    Usuario(
        uid: '1', nombre: 'Alex', online: true, email: 'cesarr11@prueba.com'),
    Usuario(
        uid: '2',
        nombre: 'Bianca',
        online: false,
        email: 'Bianca11@prueba.com'),
    Usuario(
        uid: '3', nombre: 'Cesar', online: true, email: 'Cesar11@prueba.com'),
    Usuario(
        uid: '4',
        nombre: 'Daniela',
        online: false,
        email: 'Daniela11@prueba.com'),
    Usuario(
        uid: '5', nombre: 'Erick', online: true, email: 'Erick11@prueba.com'),
    Usuario(
        uid: '6',
        nombre: 'Fernanda',
        online: false,
        email: 'Fernanda11@prueba.com'),
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthService>(context).usuario;
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(usuario.nombre),
          centerTitle: true,
          elevation: 1,
          // backgroundColor: color,
          leading: IconButton(
            onPressed: () {
              socketService.disconnect();
              context.go('/login');
              AuthService.deleteToken();
            },
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.blueAccent,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue,
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: usuarios.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => _usuarioListTile(usuarios[index]),
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.redAccent,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _refreshController.refreshCompleted();
  }
}
