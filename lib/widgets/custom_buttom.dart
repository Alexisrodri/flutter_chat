import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final Color? background;
  final Color textColor;
  final String text;
  final void Function()? onPress;

  const CustomButtom(
      {super.key,
      required this.text,
      required this.onPress,
      this.background = Colors.white10,
      this.textColor = Colors.white, 
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: background),
      onPressed: onPress,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
