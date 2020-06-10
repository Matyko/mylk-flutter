import 'package:mylk/dao/user_dao.dart';
import 'package:mylk/model/user_model.dart';

class UserRepository {
  final userDao = UserDao();

  Future getUser({Map<String, dynamic> query}) => userDao.getUser(query: query);

  Future insertUser(User user) => userDao.createUser(user);

  Future updateUser(User user) => userDao.updateUser(user);

  Future deleteUserById(int id) => userDao.deleteUser(id);

  Future deleteAllUsers() => userDao.deleteAllUsers();
}
