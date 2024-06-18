import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Motoboy.dart';
import '../view/util.dart';
import 'login_controller.dart';

class MotoboyController {
  //Adicionar uma nova Motoboy
  adicionar(context, Motoboy m) {
    FirebaseFirestore.instance
        .collection('Motoboys')
        .add(m.toJson())
        .then((resultado) {
      sucesso(context, 'Motoboy adicionada com sucesso!');
    }).catchError((e) {
      erro(context, 'Não foi possível adicionar a Motoboy.');
    }).whenComplete(() => Navigator.pop(context));
  }

  //Listar todas as Motoboys do usuário logado
  listar() {
    return FirebaseFirestore.instance
        .collection('Motoboys')
        .where('cepEntrega', isEqualTo: LoginController().cepUsuario());
  }

  pesquisar(nome) {
    return FirebaseFirestore.instance
        .collection('Motoboys')
        .where('uid', isEqualTo: LoginController().idUsuarioLogado())
        .where('nome', isEqualTo: nome);
  }

  //Excluir Motoboy
  excluir(context, id) {
    FirebaseFirestore.instance
        .collection('Motoboys')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Motoboy excluída com sucesso!'))
        .catchError((e) => erro(context, 'Não foi possível excluir a Motoboy.'));
  }

  //Atualizar uma Motoboy
  atualizar(context, id, Motoboy p) {
    FirebaseFirestore.instance
        .collection('Motoboys')
        .doc(id)
        .update(p.toJson())
        .then((value) => sucesso(context, 'Motoboy atualizada com sucesso!'))
        .catchError(
            (e) => erro(context, 'Não foi possível atualizada a Motoboy.'))
        .whenComplete(() => Navigator.pop(context));
  }
}
