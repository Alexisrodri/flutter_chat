import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/widgets.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: SafeArea(
          // minimum: EdgeInsets.only(top: ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Logo(src: 'assets/sms.png',label: 'ChatApp',),
              _Form(),
              const Labels(
                text:'¿No tienes cuenta?',
                weight: FontWeight.w200,
                secondText: 'Crea una ahora',
                secondColor: Colors.blue,
                secondSize:18,
                secondWeight: FontWeight.bold,
              ),
              // const Labels(text:'Crea una ahora',size: 18,color: Colors.blue,weight:FontWeight.bold,),
              const Text(
                'Términos y condiciones',
                style: TextStyle(fontWeight: FontWeight.w200),
              )
            ],
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
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child:  Column(
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
          // const TextField(),
          //Hacer Botono
          ElevatedButton(onPressed: (){}, child:const Text('Click') )
        ],
      ),
    );
  }
}


