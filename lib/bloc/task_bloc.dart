import 'package:mylk/model/task_model.dart';
import 'package:mylk/repository/task_repository.dart';


import 'dart:async';

class TaskBloc {
  final _taskRepository = TaskRepository();
  final _taskController = StreamController<List<Task>>.broadcast();
  get tasks => _taskController.stream;
  Map<String, dynamic>_query;

  TaskBloc() {
    getTasks(query: _query);
  }

  getTasks({Map<String, dynamic> query}) async {
    _query = query;
    _taskController.sink.add(await _taskRepository.getAllTasks(query: query));
  }

  addTask(Task task) async {
    int id = await _taskRepository.insertTask(task);
    getTasks(query: _query);
    return id;
  }

  updateTask(Task task) async {
    await _taskRepository.updateTask(task);
    getTasks(query: _query);
  }

  deleteTaskById(int id) async {
    _taskRepository.deleteTaskById(id);
    getTasks(query: _query);
  }

  dispose() {
    _taskController.close();
  }
}
