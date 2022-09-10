import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  Resposta(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(title),
        onPressed: onPressed,
      ),
    );
  }
}
