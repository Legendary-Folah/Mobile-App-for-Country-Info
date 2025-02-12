import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: text1,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Axiforma',
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Axiforma',
              color: Colors.black,
            ))
      ]),
    );
  }
}
