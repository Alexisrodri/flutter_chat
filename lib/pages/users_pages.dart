import 'package:flutter/material.dart';
import 'package:flutter_chat/models/user_response.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:flutter_chat/services/chat_services.dart';
import 'package:flutter_chat/services/socket_service.dart';
import 'package:flutter_chat/services/usuarios_services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPages extends StatefulWidget {
  const UsersPages({super.key});

  @override
  State<UsersPages> createState() => _UsersPagesState();
}

class _UsersPagesState extends State<UsersPages> {
  // final usuarios = [
  //   Usuario(
  //       uid: '1', nombre: 'Alex', online: true, email: 'cesarr11@prueba.com'),
  //   Usuario(
  //       uid: '2',
  //       nombre: 'Bianca',
  //       online: false,
  //       email: 'Bianca11@prueba.com'),
  //   Usuario(
  //       uid: '3', nombre: 'Cesar', online: true, email: 'Cesar11@prueba.com'),
  //   Usuario(
  //       uid: '4',
  //       nombre: 'Daniela',
  //       online: false,
  //       email: 'Daniela11@prueba.com'),
  //   Usuario(
  //       uid: '5', nombre: 'Erick', online: true, email: 'Erick11@prueba.com'),
  //   Usuario(
  //       uid: '6',
  //       nombre: 'Fernanda',
  //       online: false,
  //       email: 'Fernanda11@prueba.com'),
  // ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarioService = UsuariosServices();
  List<Usuario> usuarios = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

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
              color: Colors.redAccent,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: socketService.serverStatus == ServerStatus.offline
                  ? const Icon(
                      Icons.wifi_tethering_off_rounded,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.wifi_tethering,
                      color: Colors.green,
                    ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: () => _cargarUsuarios(),
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
      onTap: () {
        final chatService = Provider.of<ChatServices>(context,listen: false);
        chatService.usuarioSelect = usuario;
        context.push('/chat');
      },
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
    usuarios = await usuarioService.getUsuario();
    setState(() {});
    // await Future.delayed(const Duration(milliseconds: 200));
    _refreshController.refreshCompleted();
  }
}
