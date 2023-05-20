import 'package:flutter/material.dart';

class RatingNurse extends StatelessWidget {
  const RatingNurse({
    required this.sizeIcon,
    required this.alignSelected,
    required this.rate,
    Key? key,
  }) : super(key: key);

  final MainAxisAlignment alignSelected;
  final double sizeIcon;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignSelected,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
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
