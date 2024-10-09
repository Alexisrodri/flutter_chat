import 'package:flutter/material.dart';
import 'package:flutter_chat/models/user_response.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:flutter_chat/services/chat_services.dart';
// import 'package:flutter_chat/services/socket_service.dart';
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
    // final usuario = Provider.of<AuthService>(context).usuario;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: const Text('Chats'),
            elevation: 1,
            centerTitle: false,
            actions: [
              GestureDetector(
                  onTap: () {
                    context.push('/profile');
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.lightBlue),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.lightBlue.shade600,
                          backgroundImage: const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoqYHrsnp2ahUcv4XjDjFcgdROLRH6LhSDHg&s'),
                        ),
                      )))
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  child: TextFormField(
                    // autofocus: true,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        color: const Color(0xFF1D1D35).withOpacity(0.64),
                      ),
                      hintText: "Buscar",
                      hintStyle: TextStyle(
                        color: const Color(0xFF1D1D35).withOpacity(0.64),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5, vertical: 16.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SmartRefresher(
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
                ),
              ),
            ],
          )),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: usuarios.length,
      separatorBuilder: (context, index) => const Spacer(),
      itemBuilder: (context, index) => _usuarioListTile(usuarios[index]),
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(
          usuario.email,
        ),
        onTap: () {
          final chatService = Provider.of<ChatServices>(context, listen: false);
          chatService.usuarioSelect = usuario;
          context.push('/chat');
        },
        leading: CircleAvatarWithActiveIndicator(
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoqYHrsnp2ahUcv4XjDjFcgdROLRH6LhSDHg&s',
          isActive: usuario.online,
        ),
        trailing: const Icon(Icons.call));
  }

  _cargarUsuarios() async {
    usuarios = await usuarioService.getUsuario();
    setState(() {});
    // await Future.delayed(const Duration(milliseconds: 200));
    _refreshController.refreshCompleted();
  }
}

class CircleAvatarWithActiveIndicator extends StatelessWidget {
  const CircleAvatarWithActiveIndicator({
    super.key,
    this.image,
    this.radius = 24,
    this.isActive,
  });

  final String? image;
  final double? radius;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(image!),
        ),
        if (isActive!)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF00BF6D),
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 3),
              ),
            ),
          )
      ],
    );
  }
}
