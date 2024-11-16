import 'package:fit_app/application/entities/schedule.entity.dart';

class User {
  String _code;
  String _password;
  String _name;
  String _email;
  String _contact;
  List<Schedule> _schedules;

  User(
    this._code,
    this._password, {
    String name = '',
    String email = '',
    String contact = '',
    List<Schedule>? schedules,
  })  : _name = name,
        _email = email,
        _contact = contact,
        _schedules = schedules ?? [];

  String get code => _code;
  String get password => _password;
  String get name => _name;
  String get email => _email;
  String get contact => _contact;
  List<Schedule> get schedules => _schedules;

  set code(String value) => _code = value;
  set password(String value) => _password = value;
  set name(String value) => _name = value;
  set email(String value) => _email = value;
  set contact(String value) => _contact = value;

  String text() {
    return 'Nome: $_name, Email: $_email, Código: $_code, Senha: $_password';
  }
}
