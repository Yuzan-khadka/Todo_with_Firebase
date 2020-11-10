import 'package:flutter/foundation.dart';
import 'package:todo_with_firebase/models/task_model.dart';

class Task extends ChangeNotifier {
  bool isDone = false;
  

  updateCheckbox() {
     isDone = true;
    notifyListeners();
  }
}
