import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    required this.sizeIcon,
    required this.alignSelected,
    required this.iconType,
    required this.status,
    Key? key,
  }) : super(key: key);

  final MainAxisAlignment alignSelected;
  final double sizeIcon;
  final IconData iconType;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          Icon(iconType, color: Colors.white60, size: sizeIcon,),
          const SizedBox(width: 4.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              status? 'Aktif' : 'Tidak Aktif', 
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.white60
            ),),
          )
        ],
      ),
    );
  }
}