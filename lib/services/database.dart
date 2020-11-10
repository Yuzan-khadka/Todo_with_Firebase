import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_with_firebase/models/task_model.dart';

class DatabaseService {
  CollectionReference _taskRef = FirebaseFirestore.instance.collection('tasks');

  Future<void> addDataToFirestore(TaskModel task) async {
    try {
      await _taskRef.add(task.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateData(TaskModel task, String id) async {
    try {
      await _taskRef.doc(id).update(task.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteData(String id) async {
    try {
      await _taskRef.doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Stream<List<TaskModel>> getTaskCollection() {
    return _taskRef.snapshots().map((snapshot) => snapshot.docs
        .map((documentSnapshot) => TaskModel.fromSnapshot(documentSnapshot))
        .toList());
  }
}
