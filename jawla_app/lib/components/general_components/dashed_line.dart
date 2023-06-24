import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    required this.height,
    required this.width,
    this.lineHeight = 110,
    this.color = const Color.fromRGBO(173, 164, 165, 1),
  });

  final double height;
  final double width;
  final double? lineHeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: lineHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(height: height, width: width, color: color),
              Container(height: height, width: width, color: color),
              Container(height: height, width: width, color: color),
              Container(height: height, width: width, color: color),
              Container(height: height, width: width, color: color),
              Container(height: height, width: width, color: color),
            ],
          ),
          Container(
            width: width + 1,
            height: lineHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 0.5),
                  Color.fromRGBO(255, 255, 255, 0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
