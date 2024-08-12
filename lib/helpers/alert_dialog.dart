import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

customDialog(BuildContext context, String titulo, String subtitulo) {
  if(Platform.isAndroid){
    return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        MaterialButton(
          hoverColor: Colors.blue,
          onPressed:() => Navigator.pop(context),
          elevation: 5,
          textColor: Colors.blue,
          child: const Text('ok'),
         )
      ],
    ),
  );
  }

  showCupertinoDialog(
    context: context, 
    builder: (_) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        CupertinoDialogAction(
          onPressed: ()=> Navigator.pop(context),
          isDefaultAction: true, 
          child: const Text('Ok'),
        )
      ],
    )
  );

}
