import 'package:fit_app/application/components/exercisesPage.component.dart';
import 'package:fit_app/application/components/homePage.component.dart';
import 'package:fit_app/application/components/registerPage.component.dart';
import 'package:fit_app/application/components/schedulerPage.component.dart';
import 'package:fit_app/application/components/searchPage.component.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double
            .infinity, 
        color: Colors.grey, 
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, 
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Image.asset(
                'lib/application/assets/footer/home.png',
                height: 50,
                width: 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: Image.asset(
                'lib/application/assets/footer/register.png',
                height: 50,
                width: 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExercisesPage()),
                );
              },
              child: Image.asset(
                'lib/application/assets/footer/exercises.png',
                height: 50,
                width: 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SchedulerPage()),
                );
              },
              child: Image.asset(
                'lib/application/assets/footer/calendar.png',
                height: 50,
                width: 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
              child: Image.asset(
                'lib/application/assets/footer/search.png',
                height: 50,
                width: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
