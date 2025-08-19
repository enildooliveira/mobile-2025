import 'package:flutter/material.dart';
import 'main.dart' show auth;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login (pública)')),
      body: Center(
        child: SizedBox(
          width: 360,
          child: Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Autenticação simples para o exercício'),
                  const SizedBox(height: 16),
                  TextFormField(decoration: const InputDecoration(labelText: 'E-mail')),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.login),
                      label: const Text('Entrar'),
                      onPressed: () {
                        auth.login();
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
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
