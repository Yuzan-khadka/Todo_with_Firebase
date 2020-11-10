import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/models/task_data.dart';
import 'package:todo_with_firebase/models/task_model.dart';
import 'package:todo_with_firebase/views/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  final ScrollController scrollController;
  TaskList({
    Key key,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<List<TaskModel>>(context) ?? [];
    final isChecked = Provider.of<Task>(context).isDone;

    return AnimatedList(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      initialItemCount: task.length,
      itemBuilder: (context, index, animation) {
        final data = task[index];
        return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.blue[700],
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(2, 6),
                  blurRadius: 6.0,
                )
              ]),
          child: TaskTile(task: data),
        );
      },
    );
  }
}
