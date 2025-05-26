import 'package:flutter/material.dart';

class TextRequired extends StatelessWidget {
  const TextRequired({
    super.key, required this.text, this.textStyle, this.isRequired = true,
  });

  final String text;
  final TextStyle? textStyle;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: textStyle??const TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextSpan(
            text: isRequired ? '*' : '',
            style: const TextStyle(fontSize: 16, color: Colors.red),
          ),
        ],
      ),
    );
  }
}