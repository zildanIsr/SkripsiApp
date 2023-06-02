import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: 100,
      height: 100,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.blue,
          ),
          Expanded(
              child: Icon(
            Icons.arrow_drop_down_rounded,
            size: 32,
          ))
        ],
      ),
    );
  }
}
