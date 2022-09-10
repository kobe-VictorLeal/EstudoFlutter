import 'package:flutter/material.dart';
import './questionario.dart';
import './resultado.dart';

main() => runApp(PerguntaAPP());

class PerguntaAppState extends State<PerguntaAPP> {
  var perguntaSelecionada = 0;
  int pontuacaoTotal = 0;

  final List<Map<String, Object>> perguntas = [
    {
      "texto": "Qual a sua cor favorita?",
      "respostas": [
        {"titulo": "Azul", "pontuação": 12},
        {"titulo": "Resposta 2", "pontuação": 10},
        {"titulo": "Resposta 3", "pontuação": 7},
        {"titulo": "Resposta 4", "pontuação": 40},
      ]
    },
    {
      "texto": "Que caminhos levam a Roma?",
      "respostas": [
        {"titulo": "Caxanga", "pontuação": 12},
        {"titulo": "Resposta 2", "pontuação": 10},
        {"titulo": "Resposta 3", "pontuação": 7},
        {"titulo": "Resposta 4", "pontuação": 40},
      ]
    },
    {
      "texto": "Neguinho da Beija Flor é de que escola de samba?",
      "respostas": [
        {"titulo": "Portela", "pontuação": 12},
        {"titulo": "Resposta 2", "pontuação": 10},
        {"titulo": "Resposta 3", "pontuação": 7},
        {"titulo": "Resposta 4", "pontuação": 40},
      ]
    },
  ];

  void _responder(int pontos) {
    if (temPerguntaSelecionada) {
      setState(() {
        perguntaSelecionada++;
        pontuacaoTotal += pontos;
      });
    }
    print(pontuacaoTotal);
  }

  void _reiniciar() {
    setState(() {
      perguntaSelecionada = 0;
      pontuacaoTotal = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntas: perguntas,
                perguntaSelecionada: perguntaSelecionada,
                onPressed: _responder,
              )
            : Resultado(pontuacaoTotal, _reiniciar),
      ),
    );
  }
}

class PerguntaAPP extends StatefulWidget {
  PerguntaAppState createState() {
    return PerguntaAppState();
  }
}
