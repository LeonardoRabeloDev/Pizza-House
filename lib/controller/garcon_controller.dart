import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Garcon.dart';
import '../view/util.dart';
import 'login_controller.dart';

class GarconController {
  //Adicionar uma nova Garcon
  adicionar(context, Garcon g) {
    FirebaseFirestore.instance
        .collection('Garcons')
        .add(g.toJson())
        .then((resultado) {
      sucesso(context, 'Garcon adicionada com sucesso!');
    }).catchError((e) {
      erro(context, 'Não foi possível adicionar a Garcon.');
    }).whenComplete(() => Navigator.pop(context));
  }

  //Listar todas as Garcons do usuário logado
  listar() {
    return FirebaseFirestore.instance
        .collection('Garcons')
        .where('cepEntrega', isEqualTo: LoginController().cepUsuario());
  }

  pesquisar(nome) {
    return FirebaseFirestore.instance
        .collection('Garcons')
        .where('uid', isEqualTo: LoginController().idUsuarioLogado())
        .where('nome', isEqualTo: nome);
  }

  //Excluir Garcon
  excluir(context, id) {
    FirebaseFirestore.instance
        .collection('Garcons')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Garcon excluída com sucesso!'))
        .catchError((e) => erro(context, 'Não foi possível excluir a Garcon.'));
  }

  //Atualizar uma Garcon
  atualizar(context, id, Garcon p) {
    FirebaseFirestore.instance
        .collection('Garcons')
        .doc(id)
        .update(p.toJson())
        .then((value) => sucesso(context, 'Garcon atualizada com sucesso!'))
        .catchError(
            (e) => erro(context, 'Não foi possível atualizada a Garcon.'))
        .whenComplete(() => Navigator.pop(context));
  }
}
