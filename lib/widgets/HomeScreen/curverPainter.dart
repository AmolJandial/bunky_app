import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var brush = Paint();
    brush.style = PaintingStyle.fill;

    customCurver(0, 1, 0.80, Path(), size, canvas, Color(0XffB80F50));

    customCurver(0, 0.75, 0.55, Path(), size, canvas, Color(0xff8A0C4C));

    customCurver(0, 0.5, 0.30, Path(), size, canvas, Color(0Xff5B0B48));

    customCurver(0, 0.25, 0.05, Path(), size, canvas, Color(0xff3D0A42));
  }

  void customCurver(double startPointY, double firstLineToY,
      double controlPointY, Path path, Size size, Canvas canvas, Color color) {
    var paint = Paint();
    paint.color = color;
    path.moveTo(0, size.height * startPointY);
    path.lineTo(0, size.height * firstLineToY);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * controlPointY,
      size.width,
      size.height * firstLineToY,
    );
    path.lineTo(size.width, size.height * startPointY);
    path.lineTo(0, size.height * startPointY);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
