import 'package:flutter/material.dart';

class WorkRate extends StatelessWidget {
  const WorkRate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget> [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(4.0)
          ),
          child: Row(
            children: const [
              Icon(Icons.work_history, color: Colors.white60, size: 18,),
              SizedBox(width: 6.0,),
              Text('9 Tahun')
            ],
          ),
        ),
        const SizedBox(width: 8.0,),
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(4.0)
          ),
          child: Row(
            children: const [
              Icon(Icons.thumb_up, color: Colors.white60, size: 18),
              SizedBox(width: 6.0,),
              Text('98%')
            ],
          ),
        )
      ],
    );
  }
}