import 'package:fit_app/application/components/pages/home/landingPage.component.dart';
import 'package:fit_app/application/infra/@providers/User.provider.dart';
import 'package:fit_app/application/entities/user.entity.dart'; // Certifique-se de importar a classe User
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        // Criação do UserProvider
        UserProvider userProvider = UserProvider();

        // Adicionando um usuário pré-definido
        userProvider.addUser(
          User(
            'U001', // Código do usuário
            '1234', // Senha
            name: 'João Silva', // Nome
            email: 'joao.silva@example.com', // Email
            contact: '123456789', // Contato
          ),
        );

        return userProvider;
      },
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      home: const LandingPage(),
    );
  }
}
