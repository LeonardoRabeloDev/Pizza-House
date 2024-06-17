// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class SobreView extends StatefulWidget {
  const SobreView({super.key});

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sobre",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade500,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Text(
          "Projeto desenvolvido para obtenção de nota na disciplina Novas Tecnologias de Informação e Comunicação, " +
              "ministradas pelo professor Doutor Rodrigo de Oliveira Plotze.\n" +
              "O projeto foi feito utilizando o framework Flutter, construído na linguagem Dart e seguindo o " +
              "Paradigma de Orientação a Objetos, conforme conteúdo das aulas.\n\n"
                  "Aluno: Leonardo Guimarães Rabelo\nCódigo: 836404\n7a. etapa do curso de Engenharia da Computação - UNAERP.",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
