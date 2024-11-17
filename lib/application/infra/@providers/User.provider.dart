import 'package:fit_app/application/entities/schedule.entity.dart';
import 'package:fit_app/application/entities/user.entity.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  User? activeUser;

  final List<User> _usersList = [];

  List<User> get usersList => List.unmodifiable(_usersList);

  void addUser(User user) {
    if (!_usersList.any((u) => u.code == user.code)) {
      _usersList.add(user);
      notifyListeners();
    } else {
      print('o usuário já está cadastrado!');
    }
  }

  void addSchedule(Schedule schedule){
      if (activeUser != null){
        activeUser?.schedules.add(schedule);
      } else {
        print('usuário não encontrado');
      }
  }

  void logout(){
    activeUser?.isAuthenticated = false;
    notifyListeners();
  }

  bool validateUser(String userCode, String password) {
    try {
      final User user = _usersList.firstWhere(
        (u) => u.code == userCode && u.password == password,
      );

      activeUser = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
