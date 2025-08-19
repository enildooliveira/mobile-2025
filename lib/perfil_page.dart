import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  final Map<String, String> dados;

  const PerfilPage({super.key, required this.dados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil (privada)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dados recebidos via Map:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('Nome completo: ${dados['nomeCompleto'] ?? '-'}'),
                  Text('Data de nascimento: ${dados['dataNascimento'] ?? '-'}'),
                  Text('Telefone: ${dados['telefone'] ?? '-'}'),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
