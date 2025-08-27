import 'package:flutter/material.dart';

class Aninhada2Tela extends StatelessWidget {
  const Aninhada2Tela({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[50],
      child: const Center(
        child: Text(
          'Conteúdo da Rota Aninhada 2',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}