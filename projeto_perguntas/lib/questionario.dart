import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) onPressed;

  Questionario({
    required this.perguntas,
    required this.perguntaSelecionada,
    required this.onPressed,
  });

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada ? perguntas[perguntaSelecionada].cast()["respostas"] : [];
    List<Widget> widgets = respostas
        .map((resposta) => Resposta(
              resposta["titulo"].toString(),
              () => onPressed(int.parse(resposta["pontuação"].toString())),
            ))
        .toList();

    return Column(
      children: <Widget>[Questao(perguntas[perguntaSelecionada]["texto"].toString()), ...widgets],
    );
  }
}
