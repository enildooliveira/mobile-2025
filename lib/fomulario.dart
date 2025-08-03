// lib/formulario.dart

import 'package:flutter/material.dart';

// É uma boa prática nomear classes com a primeira letra maiúscula (PascalCase)
class formulario extends StatefulWidget {
  const formulario({super.key});

  @override
  State<formulario> createState() => _formularioState();
}

class _formularioState extends State<formulario> {
  // 1. CHAVE DO FORMULÁRIO
  // Esta chave identifica unicamente nosso formulário e nos permite validá-lo.
  final _formKey = GlobalKey<FormState>();

  // 2. CONTROLADORES E VARIÁVEIS
  // Usamos controladores para gerenciar o texto dos campos.
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

  // Variável para armazenar a data de nascimento selecionada.
  DateTime? _dataNascimento;
  // Variável para armazenar o sexo selecionado no dropdown.
  String? _sexoSelecionado;

  // 3. FUNÇÃO PARA SELECIONAR A DATA
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Data inicial que aparece no calendário
      firstDate: DateTime(1920), // Data mais antiga que pode ser selecionada
      lastDate: DateTime.now(), // Data mais recente que pode ser selecionada
    );

    if (dataSelecionada != null) {
      // setState atualiza a tela com a nova informação
      setState(() {
        _dataNascimento = dataSelecionada;
        _dataNascimentoController.text =
            "${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}";
      });
    }
  }

  // 4. FUNÇÃO PARA VALIDAR E ENVIAR
  void _cadastrar() {
    // a exclamação (!) garante ao Dart que _formKey.currentState não será nulo aqui.
    if (_formKey.currentState!.validate()) {
      // Se todos os validadores retornarem nulo (ou seja, tudo está válido)...
      print('Formulário Válido!');
      print('Nome: ${_nomeController.text}');
      print('Data de Nascimento: ${_dataNascimentoController.text}');
      print('Sexo: $_sexoSelecionado');

      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Cadastro realizado com sucesso!'),
        ),
      );
    } else {
      // Se algum validador retornar uma string (mensagem de erro)...
      print('Formulário Inválido!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Por favor, corrija os erros no formulário.'),
        ),
      );
    }
  }

  // 5. DESTRUINDO OS CONTROLADORES
  // É importante limpar os controladores da memória quando a tela não estiver mais sendo usada.
  @override
  void dispose() {
    _nomeController.dispose();
    _dataNascimentoController.dispose();
    super.dispose();
  }

  // 6. CONSTRUÇÃO DA INTERFACE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Cadastro'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            // Usamos ListView para evitar que o teclado cause overflow de pixels
            children: [
              // --- CAMPO NOME COMPLETO ---
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  if (text.trim().split(' ').length < 2) {
                    return 'Digite o nome e o sobrenome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- CAMPO DATA DE NASCIMENTO ---
              TextFormField(
                controller: _dataNascimentoController,
                readOnly: true, // Impede o usuário de digitar no campo
                decoration: const InputDecoration(
                  labelText: 'Data de Nascimento',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  // Abre o seletor de data quando o campo é tocado
                  _selecionarData(context);
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'A data de nascimento é obrigatória';
                  }
                  // Validação de Idade (+18 anos)
                  final dataAtual = DateTime.now();
                  // A exclamação (!) garante que _dataNascimento não é nulo se o texto não for vazio
                  int idade = dataAtual.year - _dataNascimento!.year;
                  if (dataAtual.month < _dataNascimento!.month ||
                      (dataAtual.month == _dataNascimento!.month &&
                          dataAtual.day < _dataNascimento!.day)) {
                    idade--;
                  }
                  if (idade < 18) {
                    return 'Você deve ter mais de 18 anos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- CAMPO SEXO ---
              DropdownButtonFormField<String>(
                value: _sexoSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Sexo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.wc),
                ),
                items: const [
                  DropdownMenuItem(value: 'Homem', child: Text('Homem')),
                  DropdownMenuItem(value: 'Mulher', child: Text('Mulher')),
                ],
                onChanged: (value) {
                  setState(() {
                    _sexoSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione o sexo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // --- BOTÃO DE CADASTRO ---
              ElevatedButton(
                onPressed: _cadastrar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('CADASTRAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
