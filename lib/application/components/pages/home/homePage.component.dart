import 'package:fit_app/application/components/widgets/defaultAppBar.widget.dart';
import 'package:fit_app/application/components/widgets/footer.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar('Home'),
      body: const Center(
        child: Text(
          'Em Desenvolvimento',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: FooterWidget(selectedIndex: 0),
    );
  }
}
