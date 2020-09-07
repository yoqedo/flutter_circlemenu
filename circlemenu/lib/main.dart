import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Circle Menu',
      home: CircularMenu(),
    );
  }
}

class CircularMenu extends StatefulWidget {
  @override
  _CircularMenuState createState() => _CircularMenuState();
}

class _CircularMenuState extends State<CircularMenu>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Tween<double> leftButton;
  Animation<double> leftButtonAnimation;
  Tween<double> topButton;
  Animation<double> topButtonAnimation;
  Tween<double> rightButton;
  Animation<double> rightButtonAnimation;
  Tween<double> rotation;
  Animation<double> rotationAnimation;
  Animation rotationScaleLeft;
  Animation rotationScaleTop;
  Animation rotationScaleRight;
  Animation<double> rotationScaleAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600))
          ..addListener(() {
            setState(() {});
          });

    leftButton = Tween<double>(begin: 0, end: -65)..animate(_controller);
    leftButtonAnimation = leftButton.animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    topButton = Tween<double>(begin: 0, end: -65)..animate(_controller);
    topButtonAnimation = topButton.animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    rightButton = Tween<double>(begin: 0, end: 65)..animate(_controller);
    rightButtonAnimation = rightButton.animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    rotation = Tween<double>(begin: pi, end: pi / 4)..animate(_controller);
    rotationAnimation = rotation
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    rotationScaleLeft = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 1.4), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    rotationScaleTop = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 1.3), weight: 80),
      TweenSequenceItem<double>(tween: Tween(begin: 1.3, end: 1.0), weight: 20),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    rotationScaleRight = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 1.30), weight: 90),
      TweenSequenceItem<double>(
          tween: Tween(begin: 1.30, end: 1.0), weight: 10),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    /*rotationScaleAnimation = rotationScale
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));*/

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Coded by @Yoqedo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 250,
          width: 250,
          //color: Colors.red,
          child: Center(
            child: Stack(children: [
              Transform.scale(
                scale: rotationScaleTop.value,
                child: Transform.translate(
                  offset: Offset(0, topButtonAnimation.value),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purpleAccent,
                    ),
                    child: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: rotationScaleLeft.value,
                child: Transform.translate(
                  offset: Offset(leftButtonAnimation.value, 0),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purpleAccent,
                    ),
                    child: Icon(
                      Icons.folder_open,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: rotationScaleRight.value,
                child: Transform.translate(
                  offset: Offset(rightButtonAnimation.value, 0),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purpleAccent,
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_controller.isCompleted) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                },
                child: Transform(
                  transform: Matrix4.rotationZ(rotationAnimation.value),
                  alignment: Alignment.center,
                  child: Container(
                    height: 58,
                    width: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurpleAccent,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
