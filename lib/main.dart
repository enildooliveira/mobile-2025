import 'package:flutter/material.dart';
import 'package:mobile_2025/home_page.dart';
import 'package:mobile_2025/login_page.dart';
import 'package:mobile_2025/perfil_page.dart';

void main() {
  runApp(const MyApp());
}

/// Serviço de autenticação MUITO simples (memória)
class AuthService extends ChangeNotifier {
  bool _logged = false;
  bool get logged => _logged;

  void login() {
    _logged = true;
    notifyListeners();
  }

  void logout() {
    _logged = false;
    notifyListeners();
  }
}

/// Instância global só para o exercício (mantém simples)
final auth = AuthService();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: auth,
      builder: (_, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rotas nomeadas (privadas)',
          // começa no login (pública)
          initialRoute: '/login',
          onGenerateRoute: (settings) {
            // Rotas privadas que exigem login:
            final isPrivate = settings.name == '/home' || settings.name == '/perfil';

            if (isPrivate && !auth.logged) {
              // bloqueia e envia ao login
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
                settings: const RouteSettings(name: '/login'),
              );
            }

            switch (settings.name) {
              case '/login':
                return MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                  settings: settings,
                );
              case '/home':
                return MaterialPageRoute(
                  builder: (_) => const HomePage(),
                  settings: settings,
                );
              case '/perfil':
                // Espera um Map como argumento
                final args = settings.arguments;
                if (args is! Map<String, String>) {
                  // defesa simples para evitar crash se vier errado
                  return MaterialPageRoute(
                    builder: (_) => const Scaffold(
                      body: Center(child: Text('Parâmetros inválidos para /perfil')),
                    ),
                  );
                }
                return MaterialPageRoute(
                  builder: (_) => PerfilPage(dados: args),
                  settings: settings,
                );
            }

            // rota desconhecida
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(child: Text('Rota não encontrada')),
              ),
            );
          },
        );
      },
    );
  }
}
