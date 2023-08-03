import 'package:flutter/material.dart';

class RatingNurse extends StatelessWidget {
  const RatingNurse({
    Key? key,
    required this.sizeIcon,
    required this.alignSelected,
    required this.rate,
    required this.mb,
    required this.mt,
  }) : super(key: key);

  final MainAxisAlignment alignSelected;
  final double sizeIcon;
  final String rate;
  final double mb;
  final double mt;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignSelected,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, mt, 0, mb),
          decoration: BoxDecoration(
              //border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4.0)),
          child: Row(
            children: <Widget>[
              Icon(Icons.star_rate_rounded,
                  color: Colors.amber[200], size: sizeIcon),
              const SizedBox(
                width: 6.0,
              ),
              Text(
                rate,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              )
            ],
          ),
        )
      ],
    );
  }
}
