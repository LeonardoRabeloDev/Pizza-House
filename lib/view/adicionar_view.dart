// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class AdicionarView extends StatefulWidget {
  const AdicionarView({super.key});

  @override
  State<AdicionarView> createState() => _AdicionarViewState();
}

class _AdicionarViewState extends State<AdicionarView> {
  var txtNome = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Adicionar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade500,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Center(
          child: Column(
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "addPizzaria");
                  },
                  child: Text("Adicionar Pizzaria")),
              SizedBox(
                height: 40,
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "addGarcon");
                  },
                  child: Text("Adcionar garçon")),
              SizedBox(
                height: 40,
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "addMotoboy");
                  },
                  child: Text("Adicionar Motoboy")),
            ],
          ),
        ),
      ),
    );
  }
}
