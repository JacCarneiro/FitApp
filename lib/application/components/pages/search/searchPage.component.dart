import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_app/application/entities/user.entity.dart';
import 'package:fit_app/application/infra/@providers/User.provider.dart';

import '../../widgets/defaultAppBar.widget.dart';
import '../../widgets/footer.widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<User> filteredUsers = [];

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
      appBar: const DefaultAppBar('Pesquisa de Usuários Cadastrados'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Campo de texto com ícone interno
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar por nome',
                border: const OutlineInputBorder(),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _filterUsers();
                    print("Pesquisar clicado!");
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Exibe a lista de usuários apenas se houver resultados da pesquisa
            filteredUsers.isEmpty
                ? const Center(
                    child: Text('Nenhum usuário encontrado.'),
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
                          trailing: IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              // Ação ao selecionar o usuário
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(user.name),
                                  content: Text(
                                    'E-mail: ${user.email}\n'
                                    'Contato: ${user.contact}',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Fechar'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: FooterWidget(selectedIndex: 5),
    );
  }
}
