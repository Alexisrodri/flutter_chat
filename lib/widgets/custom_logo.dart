import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String src;
  final String label;

  const Logo({
    super.key, 
    required this.src, 
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image.asset(src),
            const SizedBox(
              height: 20,
            ),
             Text(
              label,
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
