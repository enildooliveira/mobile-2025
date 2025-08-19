import 'package:flutter/material.dart';
import 'package:mobile_2025/formulario.dart';
import 'main.dart' show auth;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (privada)'),
        actions: [
          IconButton(
            tooltip: 'Abrir Perfil (envia Map)',
            onPressed: () {
              // Exemplo de MAP a ser passado para a rota privada /perfil
              final dadosUsuario = <String, String>{
                'nomeCompleto': 'Enildo da Silva',
                'dataNascimento': '15/04/1998',
                'telefone': '(64) 99999-0000',
              };
              Navigator.pushNamed(context, '/perfil', arguments: dadosUsuario);
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            tooltip: 'Sair',
            onPressed: () {
              auth.logout();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // Reaproveitando seu formulário como corpo da Home
      body: const Formulario(),
    );
  }
}
