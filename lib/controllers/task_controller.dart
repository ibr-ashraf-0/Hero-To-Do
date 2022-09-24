import 'package:get/get.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({required Task task}) {
    return DBHelper.insertTask(task);
  }

  void markUsCompleted({required int id}) async {
    await DBHelper.updateTask(id);
    getTasks();
  }

  void deleteTasks({required Task task}) async {
    await DBHelper.deleteTask(task);
    getTasks();
  }

  Future<void> getTasks() async {
    List<Map<String, Object?>> tasks = await DBHelper.queryTask();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }
}
