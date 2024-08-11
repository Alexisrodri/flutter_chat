import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

customDialog(BuildContext context, String titulo, String subtitulo) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        MaterialButton(
          onPressed:() => Navigator.pop(context),
          elevation: 5,
          textColor: Colors.blue,
          child: const Text('ok'),
         )
      ],
    ),
  );
}
