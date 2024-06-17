import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Pizzaria.dart';
import '../view/util.dart';
import 'login_controller.dart';

class PizzariaController {
  //Adicionar uma nova Pizzaria
  adicionar(context, Pizzaria p) {
    FirebaseFirestore.instance
        .collection('Pizzarias')
        .add(p.toJson())
        .then((resultado) {
      sucesso(context, 'Pizzaria adicionada com sucesso!');
    }).catchError((e) {
      erro(context, 'Não foi possível adicionar a Pizzaria.');
    }).whenComplete(() => Navigator.pop(context));
  }

  //Listar todas as Pizzarias do usuário logado
  listar() {
    return FirebaseFirestore.instance
        .collection('Pizzarias')
        .where('cepEntrega', isEqualTo: LoginController().cepUsuario());
  }

  pesquisar(nome) {
    return FirebaseFirestore.instance
        .collection('Pizzarias')
        .where('uid', isEqualTo: LoginController().idUsuarioLogado())
        .where('nome', isEqualTo: nome);
  }

  //Excluir Pizzaria
  excluir(context, id) {
    FirebaseFirestore.instance
        .collection('Pizzarias')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Pizzaria excluída com sucesso!'))
        .catchError((e) => erro(context, 'Não foi possível excluir a Pizzaria.'));
  }

  //Atualizar uma Pizzaria
  atualizar(context, id, Pizzaria p) {
    FirebaseFirestore.instance
        .collection('Pizzarias')
        .doc(id)
        .update(p.toJson())
        .then((value) => sucesso(context, 'Pizzaria atualizada com sucesso!'))
        .catchError(
            (e) => erro(context, 'Não foi possível atualizada a Pizzaria.'))
        .whenComplete(() => Navigator.pop(context));
  }
}
