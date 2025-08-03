// lib/main.dart

import 'package:flutter/material.dart';
// Importe o novo arquivo que criamos
import 'package:mobile_2025/fomulario.dart';

void main() {
  // Use 'const' para melhor performance em widgets que não mudam.
  // Use 'formulario()' com 'P' maiúsculo, que é o nome da nossa classe.
  runApp(
    const MaterialApp(
      home: formulario(),
      // Remover 'useMaterial3: false' para usar o design mais moderno do Flutter.
      // O código acima foi feito pensando no Material 3.
    ),
  );
}
