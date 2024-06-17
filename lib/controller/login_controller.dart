import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/util.dart';

class LoginController {
  //
  // CRIAR CONTA de um usuário no serviço Firebase Authentication
  //
  criarConta(context, nome, email, senha, cep, rua, numero) {

    if (!verificarSenha(senha)) {
      return erro(context, "Formato de senha inválido");
    }
    print(senha);

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then(
      (resultado) {
        //Usuário criado com sucesso!

        //Armazenar o NOME e UID do usuário no Firestore
        FirebaseFirestore.instance.collection("usuarios").add(
          {
            "uid": resultado.user!.uid,
            "nome": nome,
            "cep": cep,
            "rua": rua,
            "numero": numero,
          },
        );

        sucesso(context, 'Usuário criado com sucesso!');
        Navigator.pop(context);
      },
    ).catchError((e) {
      //Erro durante a criação do usuário
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.toString()}');
      }
    });
  }

  bool verificarSenha(String senha) {
    bool hasUppercase = senha.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = senha.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = senha.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        senha.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters;
  }

  //
  // LOGIN de usuário a partir do provedor Email/Senha
  //
  login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      sucesso(context, 'Usuário autenticado com sucesso!');
      Navigator.pushNamed(context, 'principal');
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
        case 'invalid-credential':
          erro(context, 'Usuário e/ou senha inválida.');
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  esqueceuSenha(context, email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      sucesso(context, 'Email enviado com sucesso.');
    } else {
      erro(context, 'Informe o email para recuperar a conta.');
    }
  }

  //
  // Efetuar logou do usuário
  //
  logout() {
    FirebaseAuth.instance.signOut();
  }

  //
  // Retornar o UID (User Identifier) do usuário que está logado no App
  //
  idUsuarioLogado() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  cepUsuario() {
    var query = FirebaseFirestore.instance
        .collection("usuarios")
        .where("uid", isEqualTo: idUsuarioLogado());

    query.get().then((querySnapshot) {
      print(querySnapshot);
    });
  }
}
