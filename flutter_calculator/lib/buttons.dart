import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  Buttons(this.color, this.buttonText, this.textColor, this.buttonTapped);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: buttonTapped,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(buttonText,
                  style: TextStyle(color: textColor, fontSize: 24)),
            ),
          ),
        ),
      ),
    );
  }
}
