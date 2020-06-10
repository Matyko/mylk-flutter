import 'package:mylk/model/user_model.dart';
import 'dart:async';
import 'package:mylk/repository/user_repository.dart';

class UserBloc {
  final _userRepository = UserRepository();
  final _userController = StreamController<User>.broadcast();
  get user => _userController.stream;
  Map<String, dynamic>_query;

  UserBloc() {
    getUser(query: _query);
  }

  getUser({Map<String, dynamic> query}) async {
    _query = query;
    _userController.sink.add(await _userRepository.getUser(query: query));
  }

  addUser(User user) async {
    await _userRepository.insertUser(user);
    getUser(query: _query);
  }

  updateUser(User user) async {
    await _userRepository.updateUser(user);
    getUser(query: _query);
  }

  deleteUserById(int id) async {
    _userRepository.deleteUserById(id);
    getUser(query: _query);
  }

  dispose() {
    _userController.close();
  }
}