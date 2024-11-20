import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_app/application/entities/user.entity.dart';
import 'package:fit_app/application/infra/@providers/User.provider.dart';

import '../../widgets/defaultAppBar.widget.dart';
import '../../widgets/footer.widget.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _sheetController = TextEditingController();
  TextEditingController _exerciseController = TextEditingController();
  TextEditingController _objectiveController = TextEditingController();
  TextEditingController _observationController = TextEditingController();
  List<User> filteredUsers = [];
  User? _selectedUser; // Variável para armazenar o usuário selecionado

  void _cadastrar() {
    // Função para cadastrar
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterUsers);
    _searchController.dispose();
    super.dispose();
  }

  void _filterUsers() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final query = _searchController.text.toLowerCase();

    if (query.isNotEmpty) {
      setState(() {
        filteredUsers = userProvider.usersList.where((user) {
          return user.name.toLowerCase().contains(query) ||
              user.email.toLowerCase().contains(query);
        }).toList();
      });
    } else {
      setState(() {
        filteredUsers = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: const DefaultAppBar('Ficha de Cadastro de Treino'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                // Campo de pesquisa
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Pesquisar por nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Espaçamento
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () {
                    if (filteredUsers.isEmpty) {
                      // Nenhum usuário encontrado
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nenhum usuário encontrado para seleção.'),
                        ),
                      );
                    } else if (filteredUsers.length == 1) {
                      // Apenas um usuário encontrado, seleciona automaticamente
                      setState(() {
                        _selectedUser = filteredUsers.first;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Usuário ${_selectedUser!.name} selecionado.'),
                        ),
                      );
                    } else {
                      // Mais de um usuário encontrado, exibe opções
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Selecione um usuário'),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                itemCount: filteredUsers.length,
                                itemBuilder: (context, index) {
                                  final user = filteredUsers[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text(user.name[0].toUpperCase()),
                                    ),
                                    title: Text(user.name),
                                    subtitle: Text(user.email),
                                    onTap: () {
                                      setState(() {
                                        _selectedUser = user;
                                      });
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Usuário ${user.name} selecionado.'),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Exibe o usuário selecionado abaixo do campo de pesquisa
            if (_selectedUser != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Text(_selectedUser!.name[0].toUpperCase()),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _selectedUser!.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _selectedUser = null; // Remove o usuário selecionado
                        });
                      },
                    ),
                  ],
                ),
              ),

            // Exibe a lista de usuários apenas se houver resultados da pesquisa
            filteredUsers.isEmpty
                ? const Center(
                    child: Text(''),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(user.name[0].toUpperCase()),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                        );
                      },
                    ),
                  ),

            // Outros campos de entrada
            TextFormField(
              controller: _sheetController,
              decoration: const InputDecoration(
                labelText: 'Nome da ficha',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da ficha';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),

            TextField(
              controller: _exerciseController,
              decoration: const InputDecoration(
                labelText: 'Exercício',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: _objectiveController,
              decoration: const InputDecoration(
                labelText: 'Objetivo',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o objetivo do treino';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: _observationController,
              decoration: const InputDecoration(
                labelText: 'Observação',
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _cadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterWidget(selectedIndex: 1),
    );
  }
}
