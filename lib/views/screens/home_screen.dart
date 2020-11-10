import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_with_firebase/views/widgets/app_header.dart';
import 'package:todo_with_firebase/views/widgets/dialog_content.dart';
import 'package:todo_with_firebase/views/widgets/list_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Future addTaskDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AddorEditTaskDialog(
            isEditTask: false,
          );
        });
  }

  AnimationController _hideFabAnimation;
  ScrollController _scrollController;

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration, value: 1,);

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          _hideFabAnimation.forward();
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          _hideFabAnimation.reverse();
          break;
        // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimation.dispose();
    super.dispose();
  }

  // ScrollController controller;
  // bool fabIsVisible = true;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = ScrollController();
  //   controller.addListener(() {
  //     setState(() {
  //       fabIsVisible =
  //           controller.position.userScrollDirection == ScrollDirection.forward;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FadeTransition(
        opacity: _hideFabAnimation,
        child: ScaleTransition(
          scale: _hideFabAnimation,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () async {
              await addTaskDialog(context);
            },
            child: Icon(
              Icons.add,
              size: 30.0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          AppHeader(),
          Expanded(
            child: ListContainer(controller: _scrollController),
          ),
        ],
      ),
    );
  }
}
