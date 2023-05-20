import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollHideBottomBar extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollHideBottomBar(
      {super.key,
      required this.child,
      required this.controller,
      this.duration = const Duration(milliseconds: 200)});

  @override
  State<ScrollHideBottomBar> createState() => _ScrollHideBottomBarState();
}

class _ScrollHideBottomBarState extends State<ScrollHideBottomBar> {
  bool inVisible = false;

  @override
  void initState() {
    widget.controller.addListener(listen);

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);

    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      showUp();
    } else if (direction == ScrollDirection.reverse) {
      onhide();
    } else if (direction == ScrollDirection.idle) {
      showUp();
    }
  }

  void showUp() {
    if (!inVisible) {
      setState(() {
        inVisible = true;
      });
    }
  }

  void onhide() {
    if (inVisible) {
      setState(() {
        inVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: inVisible ? 80 : 0,
      child: Wrap(
        children: [widget.child],
      ),
    );
  }
}
