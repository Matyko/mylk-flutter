import 'package:mylk/dao/task_dao.dart';
import 'package:mylk/model/task_model.dart';

class TaskRepository {
  final taskDao = TaskDao();

  Future getAllTasks({Map<String, dynamic> query}) => taskDao.getTasks(query: query);

  Future insertTask(Task task) => taskDao.createTask(task);

  Future updateTask(Task task) => taskDao.updateTask(task);

  Future deleteTaskById(int id) => taskDao.deleteTask(id);

  Future deleteAllTasks() => taskDao.deleteAllTasks();
}
