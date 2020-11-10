import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/models/task_data.dart';
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
            child: Consumer<Task>(
              builder: (context, taskData, child) {
                return Checkbox(
                    checkColor: Colors.green,
                    activeColor: Colors.white,
                    value: taskData.isDone,
                    onChanged: (value) async {
                      value = taskData.updateCheckbox();
                      await Future.delayed(Duration(milliseconds: 1000), () {
                        _databaseService.deleteData(task.id);
                      });
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
