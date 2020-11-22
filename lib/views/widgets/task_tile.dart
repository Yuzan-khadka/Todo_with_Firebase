import 'package:flutter/material.dart';
import 'package:todo_with_firebase/models/task_model.dart';
import 'package:todo_with_firebase/services/database.dart';
import 'package:todo_with_firebase/views/widgets/dialog_content.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    Key key,
    @required this.task,
  }) : super(key: key);

  final TaskModel task;
  final TaskModel taskModel = TaskModel();
  final DatabaseService _databaseService = DatabaseService();

  Future editTaskDialog(BuildContext context, TaskModel task) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AddorEditTaskDialog(isEditTask: true, task: task);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              print(task.id);
              await editTaskDialog(context, task);
            },
            color: Colors.white,
          ),
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
                checkColor: Colors.green,
                activeColor: Colors.white,
                value: task.isDone,
                onChanged: (value) async {
                  await _databaseService.updateData(
                      TaskModel(isDone: true, name: task.name), task.id);
                  value = task.isDone;

                  await Future.delayed(Duration(milliseconds: 2500), () {
                    _databaseService.deleteData(task.id);
                  });
                }),
          )
        ],
      ),
    );
  }
}
