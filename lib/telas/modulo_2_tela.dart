import 'package:flutter/material.dart';
import 'package:mobile_2025/telas/aninhadas/aninhada_1_tela.dart';
import 'package:mobile_2025/telas/aninhadas/aninhada_2_tela.dart';

class Modulo2Tela extends StatelessWidget {
  const Modulo2Tela({super.key});

  @override
  Widget build(BuildContext context) {
    // O DefaultTabController é essencial para conectar a TabBar com a TabBarView.
    return DefaultTabController(
      length: 2, // Número de abas
      child: Column(
        children: <Widget>[
          // A TabBar fica aqui, no topo do corpo da tela do Módulo 2.
          Container(
            color: Colors.indigo[100],
            child: const TabBar(
              labelColor: Colors.indigo,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.indigo,
              tabs: [
                Tab(icon: Icon(Icons.directions_car), text: 'Aba 1'),
                Tab(icon: Icon(Icons.directions_bike), text: 'Aba 2'),
              ],
            ),
          ),
          // A Expanded faz com que a TabBarView ocupe todo o espaço restante.
          const Expanded(
            child: TabBarView(
              children: [
                // Conteúdo de cada aba
                Aninhada1Tela(),
                Aninhada2Tela(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
