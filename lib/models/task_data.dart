import 'package:flutter/foundation.dart';
import 'package:todo_with_firebase/models/task_model.dart';

class Task extends ChangeNotifier {
  updateCheckbox(TaskModel task) {
    task.toggleDone();
    notifyListeners();
  }
}
