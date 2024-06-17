// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../controller/login_controller.dart';

class CadastrarView extends StatefulWidget {
  const CadastrarView({super.key});

  @override
  State<CadastrarView> createState() => _CadastrarViewState();
}

class _CadastrarViewState extends State<CadastrarView> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  String cepSelecionado = "";
  var txtRua = TextEditingController();
  var txtNumero = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Column(
          children: [
            Text(
              'Criar Conta',
              style: TextStyle(fontSize: 60),
            ),
            SizedBox(height: 60),
            TextField(
              controller: txtNome,
              decoration: InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 15),
            TextField(
              controller: txtEmail,
              decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 15),
            TextField(
              controller: txtSenha,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownMenu(
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
                  DropdownMenuEntry(value: "14091-530", label: "14532-840"),
                  DropdownMenuEntry(value: "14091-530", label: "14871-041"),
                  DropdownMenuEntry(value: "14091-530", label: "14961-630"),
                ],
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: txtRua,
              decoration: InputDecoration(
                  labelText: 'Rua', border: OutlineInputBorder()),
            ),
            SizedBox(height: 15),
            TextField(
              controller: txtNumero,
              decoration: InputDecoration(
                  labelText: 'Número', border: OutlineInputBorder()),
            ),
            SizedBox(height: 40),
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
                    LoginController().criarConta(
                      context,
                      txtNome.text,
                      txtEmail.text,
                      txtSenha.text,
                      cepSelecionado,
                      txtRua.text,
                      txtNumero.text,
                    );
                  },
                  child: Text('salvar'),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
