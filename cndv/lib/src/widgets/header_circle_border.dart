import 'package:flutter/material.dart';

class HeaderCircleBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderDrawingRounded(),
      ),
    );
  }
}

class _HeaderDrawingRounded extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        new Rect.fromCircle(center: Offset(0.0, 55.0), radius: 180);

    final Gradient gradient = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFF80D8FF),
          Color(0xFF40C4FF),
          Color(0xFF00B0FF)
        ],
        stops: [
          0.0,
          0.5,
          1.0
        ]);

    final painter = new Paint();
    //final painter = new Paint()..shader = gradient.createShader(rect);

    painter.color = Colors.lightBlue;
    painter.style = PaintingStyle.fill;
    painter.strokeWidth = 20;

    final path = new Path();
    path.lineTo(0, size.height * 0.40);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.20, size.width, size.height * 0.40);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
