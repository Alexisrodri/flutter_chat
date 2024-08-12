import 'package:flutter/material.dart';
import 'package:flutter_chat/helpers/alert_dialog.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:flutter_chat/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: SafeArea(
          // minimum: EdgeInsets.only(top: ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(
                    src: 'assets/sms.png',
                    label: 'ChatApp',
                  ),
                  _Form(),
                  const Labels(
                    text: '¿No tienes cuenta?',
                    weight: FontWeight.w200,
                    secondText: 'Crea una ahora',
                    secondColor: Colors.blue,
                    secondSize: 18,
                    secondWeight: FontWeight.bold,
                    route: '/register',
                  ),
                  // const Labels(text:'Crea una ahora',size: 18,color: Colors.blue,weight:FontWeight.bold,),
                  const Text(
                    'Términos y condiciones',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            textController: emailCtrl,
            label: 'Email',
            icon: Icons.mail_outline,
            type: TextInputType.emailAddress,
          ),
          CustomInput(
            textController: passCtrl,
            label: 'Passwod',
            isPassword: true,
            icon: Icons.lock_outline_rounded,
            type: TextInputType.visiblePassword,
          ),
          CustomButtom(
            text: 'Ingrese',
            background: Colors.blue,
            onPress: authService.authenticate
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk) {
                    } else {
                      customDialog(context, 'Login Incorrecto', 'Credenciales incorrectas');
                    }
                  },
          )
        ],
      ),
    );
  }
}
