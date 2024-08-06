import 'package:flutter/material.dart';

class LoginPages extends StatelessWidget {
   
  const LoginPages({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body:SafeArea(
        // minimum: EdgeInsets.only(top: ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Logo(),
            _Form(),
            _Labels(),
            const Text('Términos y condiciones',style: TextStyle(fontWeight: FontWeight.w200),)
          ],
        ),
      )
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 170,
        child: Column(
          children: [
            Image.asset('assets/sms.png'),
            const SizedBox(height: 20,),
            const Text('ChatApp',style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(),
        const TextField(),
        ElevatedButton(onPressed: (){}, child:const Text('Click') )
      ],
    );
  }
}

class _Labels extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Text('¿No tienes cuenta?',style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w300),),
        const SizedBox(height: 10,),
        Text('Crea una ahora',style: TextStyle(color: Colors.blue[600],fontSize: 18,fontWeight: FontWeight.bold),)
      ],
    );
  }
}