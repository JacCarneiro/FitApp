import 'package:fit_app/application/components/cadastro.component.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Este widget é a raiz da sua aplicação.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Nome da aplicação
      title: 'Login App',
      // Tema da aplicação
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // A tela inicial da aplicação
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controladores para os campos de texto
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remover a cor de fundo da AppBar e deixá-la transparente
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent, // Fundo transparente
        elevation: 0, // Remover a sombra da AppBar
        iconTheme:
            IconThemeData(color: Colors.white), // Cor do ícone (se houver)
      ),
      backgroundColor: Color(0xFF38c958), // Cor de fundo #38c958
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Exibindo a imagem
                Image.asset(
                  'application/assets/logo.png', // Caminho da imagem (suba a imagem na pasta assets)
                  height: 200, // Ajusta o tamanho da imagem
                  width: 200,
                ),
                SizedBox(height: 20), // Espaço entre a imagem e o texto
                Text(
                  'Olá, faça seu login ou cadastre-se',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: 30), // Espaço entre o texto e os campos de texto
                // Campo para a matrícula
                TextField(
                  controller: _matriculaController,
                  decoration: InputDecoration(
                    labelText: 'Matrícula',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16), // Espaço entre os campos de texto
                // Campo para a senha
                TextField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  obscureText: true, // Senha será mascarada
                ),
                SizedBox(height: 30), // Espaço entre o campo senha e os botões
                // Botão Entrar
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão Entrar
                    String matricula = _matriculaController.text;
                    String senha = _senhaController.text;
                    // Aqui você pode adicionar a lógica de validação de login
                    print('Matrícula: $matricula, Senha: $senha');
                  },
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Cor de fundo do botão
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20), // Espaço entre os botões
                // Botão Cadastrar
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                    );
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}