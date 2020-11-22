import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/models/task_model.dart';
import 'package:todo_with_firebase/views/widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  final ScrollController scrollController;
  const TaskList({
    Key key,
    this.scrollController,
  }) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<List<TaskModel>>(context) ?? [];
    return task.isEmpty
        ? Center(child: Text('No tasks created'))
        : ListView.builder(
            controller: widget.scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            itemCount: task.length,
            itemBuilder: (context, index) {
              final data = task[index];
              return AnimatedOpacity(
                duration: Duration(milliseconds: 2500),
                opacity: data.isDone ? 0 : 1,
                child: Container(
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
                ),
              );
            },
          );
  }
}
