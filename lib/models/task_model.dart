import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String name;
  bool isDone;

  TaskModel({this.id, this.name, this.isDone = false});

  void toggleDone() {
    isDone = true;
  }

  TaskModel.fromSnapshot(QueryDocumentSnapshot doc) {
    id = doc.id;
    name = doc['name'];
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
