// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import '../controller/tarefa_controller.dart';
import '../model/tarefa.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  var txtTitulo = TextEditingController();
  var txtDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
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
          stream: TarefaController().listar().snapshots(),

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
                          title: Text(doc['titulo']),
                          subtitle: Text(doc['descricao']),

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
                                      txtTitulo.text = doc['titulo'];
                                      txtDescricao.text = doc['descricao'];
                                      salvarTarefa(context, docId: id);
                                    },
                                    icon: Icon(Icons.edit_outlined),
                                  ),
                                ),

                                //
                                // EXCLUIR
                                //
                                IconButton(
                                  onPressed: () {
                                    TarefaController().excluir(context, id);
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
          salvarTarefa(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //
  // ADICIONAR TAREFA
  //
  void salvarTarefa(context, {docId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(docId == null ? "Adicionar Tarefa" : "Editar Tarefa"),
          content: SizedBox(
            height: 250,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: txtTitulo,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: txtDescricao,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
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
                txtTitulo.clear();
                txtDescricao.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                //criar objeto Tarefa
                var t = Tarefa(
                  LoginController().idUsuarioLogado(),
                  txtTitulo.text,
                  txtDescricao.text,
                );

                txtTitulo.clear();
                txtDescricao.clear();

                if (docId == null) {
                  TarefaController().adicionar(context, t);
                } else {
                  TarefaController().atualizar(context, docId, t);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
