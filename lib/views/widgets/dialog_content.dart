import 'package:flutter/material.dart';
import 'package:todo_with_firebase/models/task_model.dart';
import 'package:todo_with_firebase/services/database.dart';

class AddorEditTaskDialog extends StatefulWidget {
  final bool isEditTask;
  final TaskModel task;
  AddorEditTaskDialog({
    Key key,
    this.isEditTask,
    this.task,
  }) : super(key: key);

  @override
  _AddorEditTaskDialogState createState() => _AddorEditTaskDialogState();
}

class _AddorEditTaskDialogState extends State<AddorEditTaskDialog> {
  final TextEditingController _textController = TextEditingController();

  final DatabaseService _databaseService = DatabaseService();

  dialogButton(String buttonLabel, Color buttonColor, Function onPress) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 13.0),
        onPressed: onPress,
        child: Text(
          buttonLabel,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        color: buttonColor,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.isEditTask ? _textController.text = widget.task.name : _textController.text = null; 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Theme.of(context).primaryColor,
      title: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 15.0),
        child: Text(
          widget.isEditTask ? 'Edit Task' : 'Add New Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      content: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                        hintText: 'Enter a task name',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.5,
                        ))),
                  )),
              dialogButton(
                  widget.isEditTask ? 'Edit' : 'Add',
                  Theme.of(context).primaryColor,
                  widget.isEditTask
                      ? () async {
                          await _databaseService.updateData(
                              TaskModel(name: _textController.text),
                              widget.task.id);
                          Navigator.of(context).pop();
                        }
                      : () async {
                          await _databaseService.addDataToFirestore(
                              TaskModel(name: _textController.text));
                          Navigator.of(context).pop();
                        }),
              SizedBox(
                height: 10.0,
              ),
              dialogButton('Cancel', Colors.redAccent, () {
                Navigator.of(context).pop();
              }),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
