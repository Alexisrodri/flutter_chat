import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final Color background;
  final TextEditingController textController;
  final bool isPassword;
  final TextInputType type;
  final IconData icon;

  const CustomInput({
    super.key,
    required this.label,
    required this.type,
    required this.textController,
    this.background = Colors.white,
    this.icon = Icons.abc,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.black.withOpacity(0.05),
        //       offset: const Offset(0, 5),
        //       blurRadius: 5),
        // ],
      ),
      child: TextField(
        controller: textController,
        textAlignVertical: TextAlignVertical.center,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: label),
      ),
    );
  }
}
