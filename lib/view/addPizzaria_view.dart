// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:app08/controller/login_controller.dart';
import 'package:app08/controller/pizzaria_controller.dart';
import 'package:app08/model/Pizzaria.dart';
import 'package:flutter/material.dart';

class AddPizzariaView extends StatefulWidget {
  const AddPizzariaView({super.key});

  @override
  State<AddPizzariaView> createState() => _AddPizzariaViewState();
}

class _AddPizzariaViewState extends State<AddPizzariaView> {
  var txtNome = TextEditingController();
  var txtAvaliacao = TextEditingController();
  var txtTempoEntrega = TextEditingController();
  String cepSelecionado = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Adicionar Pizzaria",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade500,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: txtNome,
                decoration: InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.text_fields),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: txtAvaliacao,
                decoration: InputDecoration(
                    labelText: 'Avaliação',
                    prefixIcon: Icon(Icons.star),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),TextField(
                controller: txtTempoEntrega,
                decoration: InputDecoration(
                    labelText: 'Tempo de entrega',
                    prefixIcon: Icon(Icons.star),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancelar'),
                  ),
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(140, 40),
                    ),
                    onPressed: () {
                      PizzariaController().adicionar(
                        context,
                        Pizzaria(
                          LoginController().idUsuarioLogado(),
                        txtNome.text,
                        int.parse(txtAvaliacao.text),
                        int.parse(txtTempoEntrega.text),
                        )
                      );
                    },
                    child: Text('salvar'),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
