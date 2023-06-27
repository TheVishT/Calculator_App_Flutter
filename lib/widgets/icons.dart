import 'package:flutter/material.dart';

class CalculatorIcon extends StatelessWidget {
  const CalculatorIcon(
      {super.key,
      required this.text,
      required this.textColour,
      required this.buttonColour,
      required this.callback});
  final String text;
  final int textColour;
  final int buttonColour;
  final Function callback;

  const CalculatorIcon.red({
    super.key,
    required this.text,
    required this.callback,
  })  : textColour = 0xFFFFFFFF,
        buttonColour = 0xFF424242;

  const CalculatorIcon.black({
    super.key,
    required this.text,
    required this.callback,
  })  : textColour = 0xFF00E676,
        buttonColour = 0xFF424242;

  const CalculatorIcon.white({
    super.key,
    required this.text,
    required this.callback,
  })  : textColour = 0xFFFFFFFF,
        buttonColour = 0xFF424242;

  const CalculatorIcon.equals({
    super.key,
    required this.text,
    required this.callback,
  })  : textColour = 0xFF424242,
        buttonColour = 0xFF00E676;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.5),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(buttonColour),
      ),
      child: TextButton(
        onPressed: () {
          callback();
        },
        style: TextButton.styleFrom(
          foregroundColor: Color(textColour),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
