import 'dart:ui';

import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color container = Color(0x5098B2E2);
  static const Color divider = Color(0xffAEAEAE);
  static const Color tabbarclr = Color(0xffF5F8FB);
  static const Color bluedark = Color(0xff00008B);
  static const Color textgrey = Color(0xff363636);
  static const Color lightblue = Color(0xff98B2E2);
  static const classbrdrclr = Color(0xffDCE4F2);
  static const classclr = Color(0xffF5F8FB);
  static const tabbarclr2 = Color(0xffE7ECF8);
}

class CustomImage {
  static const ImageProvider defaultImage = NetworkImage(
      'https://i.pinimg.com/736x/2c/f5/58/2cf558ab8c1f12b43f7326945672805e.jpg');
}

class RoundedRectangleClipper extends CustomClipper<Path> {
  final double radius;

  RoundedRectangleClipper({this.radius = 80.0}); // Reduced radius

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(radius),
    ));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DottedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        50, // Adjust the number of dots based on your requirements
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey[300],
            height: 1,
          ),
        ),
      ),
    );
  }
}

class DottedBorderContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: w * 0.56,
      height: h * 0.03,
      decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.blue,
          //   width: 2,
          // ),
          ),
      child: CustomPaint(
        painter: DottedBorderPainter(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Copy you code',
                  style: TextStyle(fontSize: 6, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Py54seds',
                style: TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                height: h * 0.03,
                width: w * 0.02,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    'Invite',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dashWidth = 5.0;
    final dashSpace = 5.0;
    final borderRadius = 10.0; // Adjust this value for desired border radius

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    // Draw dashed border along the path
    final path = Path()..addRRect(rrect);
    final dashPath = _createDashPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashPath(Path source, double dashWidth, double dashSpace) {
    final dashPath = Path();
    for (PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final start = distance;
        final end = distance + dashWidth;
        dashPath.addPath(
          pathMetric.extractPath(start, end),
          Offset.zero,
        );
        distance = end + dashSpace;
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

