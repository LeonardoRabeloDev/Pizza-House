// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:app08/model/Pizzaria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import '../controller/pizzaria_controller.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  var txtNome = TextEditingController();
  var txtAvaliacao = TextEditingController();
  String cepSelecionado = "";
  var txtTempoEntrega = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizzas'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'sair',
            onPressed: () {
              LoginController().logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),

      // BODY
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          //fluxo de dados em tempo real
          stream: PizzariaController().listar().snapshots(),

          //exibição dos dados
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              //sem conexão
              case ConnectionState.none:
                return Center(
                  child: Text('Não foi possível conectar.'),
                );

              //aguardando a execução da consulta
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              //Ufa, deu certo!
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      String id = dados.docs[index].id;
                      dynamic doc = dados.docs[index].data();
                      return Card(
                        child: ListTile(
                          title: Text(doc['nome']),
                          subtitle: Text(doc['avaliacao'].toString()),

                          //excluir
                          trailing: SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  //
                                  // ATUALIZAR
                                  //
                                  child: IconButton(
                                    onPressed: () {
                                      txtNome.text = doc['nome'];
                                      txtAvaliacao.text =
                                          doc['avaliacao'].toString();

                                      salvarPizzaria(context, docId: id);
                                    },
                                    icon: Icon(Icons.edit_outlined),
                                  ),
                                ),

                                //
                                // EXCLUIR
                                //
                                IconButton(
                                  onPressed: () {
                                    PizzariaController().excluir(context, id);
                                  },
                                  icon: Icon(Icons.delete_outlined),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Nenhuma tarefa encontrada.'),
                  );
                }
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          salvarPizzaria(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //
  // ADICIONAR TAREFA
  //
  void salvarPizzaria(context, {docId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(docId == null ? "Adicionar Pizzaria" : "Editar Pizzaria"),
          content: SizedBox(
            height: 300,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: txtNome,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: txtAvaliacao,
                  decoration: InputDecoration(
                    labelText: 'Avaliação',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: DropdownMenu(
                    initialSelection: cepSelecionado,
                    width: 250,
                    label: const Text("Selecione o CEP"),
                    enableSearch: false,
                    onSelected: (cep) {
                      if (cep != null) {
                        setState(() {
                          cepSelecionado = cep.toString();
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry>[
                      DropdownMenuEntry(value: "14091-530", label: "14091-530"),
                      DropdownMenuEntry(value: "14532-840", label: "14532-840"),
                      DropdownMenuEntry(value: "14871-041", label: "14871-041"),
                      DropdownMenuEntry(value: "14961-630", label: "14961-630"),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: txtTempoEntrega,
                  decoration: InputDecoration(
                    labelText: 'Tempo de entrega (minutos)',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            TextButton(
              child: Text("fechar"),
              onPressed: () {
                txtNome.clear();
                txtAvaliacao.clear();
                cepSelecionado = "";
                txtTempoEntrega.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                //criar objeto Tarefa
                var p = Pizzaria(
                  LoginController().idUsuarioLogado(),
                  txtNome.text,
                  int.parse(txtAvaliacao.text),
                  int.parse(txtTempoEntrega.text),
                );

                txtNome.clear();
                txtAvaliacao.clear();

                if (docId == null) {
                  PizzariaController().adicionar(context, p);
                } else {
                  PizzariaController().atualizar(context, docId, p);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
