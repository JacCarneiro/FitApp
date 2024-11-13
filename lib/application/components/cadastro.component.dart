import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();
  final TextEditingController _contatoController = TextEditingController();

  // Função que gera uma matrícula aleatória
  String _gerarMatricula() {
    int randomMatricula =
        1000 + (1000 * (DateTime.now().millisecondsSinceEpoch % 100));
    return randomMatricula.toString();
  }

  // Função de cadastro
  void _cadastrar() {
    if (_formKey.currentState?.validate() ?? false) {
      String nome = _nomeController.text;
      String email = _emailController.text;
      String senha = _senhaController.text;
      String confirmaSenha = _confirmaSenhaController.text;
      String contato = _contatoController.text;

      String matricula = _gerarMatricula();

      // Aqui você pode adicionar a lógica para enviar esses dados para uma API ou banco de dados
      print('Cadastro realizado: $nome, $email, $matricula, $senha');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Cadastro realizado com sucesso! Matrícula: $matricula')),
      );

      // Após o cadastro, redireciona para a tela de login
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Usuário',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Campo para nome
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo para e-mail
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo para senha
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo para confirmar a senha
              TextFormField(
                controller: _confirmaSenhaController,
                decoration: InputDecoration(
                  labelText: 'Confirme sua senha',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, confirme sua senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Campo para contato
              TextFormField(
                controller: _contatoController,
                decoration: InputDecoration(
                  labelText: 'Contato',
                ),
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu contato';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Botão para realizar o cadastro
              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: _cadastrar,
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}