import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Image.asset('assets/todo-list.png'),
          ),
          Positioned(
            bottom: 15.0,
            child: Text(
              'TODO APP',
              style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              left: 30.0,
              top: 30.0,
              child: Icon(
                Icons.list,
                size: 40.0,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
