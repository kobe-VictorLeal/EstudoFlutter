import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int resultado;
  final void Function() reiniciar;

  Resultado(this.resultado, this.reiniciar);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("Parabéns, você fez $resultado pontos", style: TextStyle(fontSize: 28))),
        ElevatedButton(
          child: Text("Reiniciar"),
          onPressed: reiniciar,
        )
      ],
    );
  }
}
