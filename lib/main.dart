import 'package:flutter/material.dart';
import 'package:mobile_2025/telas/modulo_1_tela.dart';
import 'package:mobile_2025/telas/modulo_2_tela.dart';
import 'package:mobile_2025/telas/modulo_3_tela.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio Flutter',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _indiceSelecionado = 0;

  // Lista de telas que serão exibidas
  static const List<Widget> _telas = <Widget>[
    Modulo1Tela(),
    Modulo2Tela(), // A tela que terá a TabBar aninhada
    Modulo3Tela(),
  ];

  void _aoTocarNoItem(int index) {
    setState(() {
      _indiceSelecionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App NavigationBar')),
      body: Center(child: _telas.elementAt(_indiceSelecionado)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Módulo 1'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Módulo 2'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Módulo 3'),
        ],
        currentIndex: _indiceSelecionado,
        selectedItemColor: Colors.indigo,
        onTap: _aoTocarNoItem,
      ),
    );
  }
}
