// ignore_for_file: prefer_const_constructors

import 'package:app08/view/addGarcon_view.dart';
import 'package:app08/view/addMotoboy_view.dart';
import 'package:app08/view/addPizzaria_view.dart';
import 'package:app08/view/adicionar_view.dart';
import 'package:app08/view/sobre_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'view/cadastrar_view.dart';
import 'view/login_view.dart';
import 'view/principal_view.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(39, 211, 105, 105)),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginView(),
        'cadastrar': (context) => CadastrarView(),
        'principal': (context) => PrincipalView(),
        'sobre': (context) => SobreView(),
        'adicionar': (context) => AdicionarView(),
        'addGarcon': (context) => AddGarconView(),
        'addPizzaria': (context) => AddPizzariaView(),
        'addMotoboy': (context) => AddMotoboyView(),
      },
    );
  }
}
