import 'package:flutter/material.dart';

class Aninhada1Tela extends StatelessWidget {
  const Aninhada1Tela({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: const Center(
        child: Text(
          'Conteúdo da Rota Aninhada 1',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}