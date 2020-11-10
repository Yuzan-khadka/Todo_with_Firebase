import 'package:flutter/material.dart';
import 'package:todo_with_firebase/views/widgets/task_list.dart';

class ListContainer extends StatelessWidget {
  final ScrollController controller;
  const ListContainer({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      //fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
                child: Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: TaskList(scrollController: controller),
              ),
            ],
          ),
        ),
        Positioned(
          top: -180.0,
          right: -45.0,
          child: Image.asset(
            'assets/pencil.png',
            height: size.height * 0.38,
          ),
        ),
      ],
    );
  }
}
