import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  // Controla o carrossel
  final _pageController = PageController(viewportFraction: 0.88);
  int _paginaAtual = 0;

  // Modelo de dados/controles por card
  final List<_PessoaForm> _forms = [
    _PessoaForm(), // começa com 1 card
  ];

  void _adicionarCard() {
    setState(() {
      _forms.add(_PessoaForm());
      // pula para o novo card
      Future.delayed(const Duration(milliseconds: 150), () {
        _pageController.animateToPage(
          _forms.length - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  void _removerCardAtual() {
    if (_forms.length == 1) return;
    setState(() {
      _forms.removeAt(_paginaAtual);
      if (_paginaAtual >= _forms.length) _paginaAtual = _forms.length - 1;
    });
  }

  void _enviarAtual() {
    final form = _forms[_paginaAtual];
    if (form.formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulário válido!')),
      );
      // Aqui você teria os dados:
      debugPrint('--- CARD ${_paginaAtual + 1} ---');
      debugPrint('Nome: ${form.nome.text}');
      debugPrint('Data: ${form.dataController.text}');
      debugPrint('Sexo: ${form.sexoSelecionado}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Corrija os erros do formulário.')),
      );
    }
  }

  @override
  void dispose() {
    for (final f in _forms) {
      f.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrossel de Micro-Formulários'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Indicadores de página (bolinhas)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_forms.length, (i) {
              final ativo = i == _paginaAtual;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: ativo ? 22 : 8,
                decoration: BoxDecoration(
                  color: ativo ? tema.colorScheme.primary : tema.disabledColor,
                  borderRadius: BorderRadius.circular(99),
                ),
              );
            }),
          ),

          const SizedBox(height: 12),

          // CARROSSEL
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _paginaAtual = i),
              itemCount: _forms.length,
              itemBuilder: (context, index) {
                return _MicroFormularioCard(form: _forms[index], index: index);
              },
            ),
          ),

          // Botões de ação
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _enviarAtual,
                    icon: const Icon(Icons.check),
                    label: Text('Cadastrar (Card ${_paginaAtual + 1})'),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _removerCardAtual,
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Remover card atual'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _adicionarCard,
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar novo card'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Card visual do micro-formulário
class _MicroFormularioCard extends StatelessWidget {
  final _PessoaForm form;
  final int index;

  const _MicroFormularioCard({required this.form, required this.index});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Card(
          elevation: 6,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: form.formKey,
              child: ListView(
                children: [
                  Text(
                    'Cadastro #${index + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),

                  // Nome
                  TextFormField(
                    controller: form.nome,
                    decoration: const InputDecoration(
                      labelText: 'Nome Completo',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'O nome é obrigatório';
                      }
                      if (text.trim().split(' ').length < 2) {
                        return 'Informe nome e sobrenome';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Data de Nascimento (abre showDatePicker)
                  TextFormField(
                    controller: form.dataController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Data de Nascimento',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () => form.selecionarData(context),
                    validator: (_) {
                      if (form.dataSelecionada == null) {
                        return 'Selecione a data de nascimento';
                      }
                      // valida 18+
                      final hoje = DateTime.now();
                      var idade = hoje.year - form.dataSelecionada!.year;
                      if (hoje.month < form.dataSelecionada!.month ||
                          (hoje.month == form.dataSelecionada!.month &&
                              hoje.day < form.dataSelecionada!.day)) {
                        idade--;
                      }
                      if (idade < 18) {
                        return 'É necessário ter 18 anos ou mais';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Sexo
                  DropdownButtonFormField<String>(
                    value: form.sexoSelecionado,
                    decoration: const InputDecoration(
                      labelText: 'Sexo',
                      prefixIcon: Icon(Icons.wc),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Homem', child: Text('Homem')),
                      DropdownMenuItem(value: 'Mulher', child: Text('Mulher')),
                    ],
                    onChanged: (v) => form.sexoSelecionado = v,
                    validator: (v) =>
                        v == null ? 'Selecione o sexo' : null,
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

/// Guarda controladores/estado de um micro-formulário
class _PessoaForm {
  final formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final dataController = TextEditingController();
  DateTime? dataSelecionada;
  String? sexoSelecionado;

  Future<void> selecionarData(BuildContext context) async {
    final agora = DateTime.now();
    final selecionada = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1920, 1, 1),
      lastDate: DateTime(agora.year, agora.month, agora.day),
    );
    if (selecionada != null) {
      dataSelecionada = selecionada;
      dataController.text =
          '${selecionada.day.toString().padLeft(2, '0')}/'
          '${selecionada.month.toString().padLeft(2, '0')}/'
          '${selecionada.year}';
    }
  }

  void dispose() {
    nome.dispose();
    dataController.dispose();
  }
}
