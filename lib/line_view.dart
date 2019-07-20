import 'package:flutter/material.dart';
import 'package:gesture_recognition/point.dart';

class LineView extends CustomPainter {

  final List<Point> pathPoints;
  final Color selectColor;
  final double lineWidth;
  final Point curPoint;

  LineView({
    @required this.pathPoints,
    @required this.selectColor,
    @required this.lineWidth,
    @required this.curPoint
  });

  @override
  void paint(Canvas canvas, Size size) {

    int length = pathPoints.length;

    if (length < 1) return;

    final linePaint = Paint()
      ..isAntiAlias = true
      ..color  = this.selectColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = this.lineWidth;



    for (int i = 0 ; i < length - 1 ; i++) {
      canvas.drawLine(
          Offset(pathPoints[i].x, pathPoints[i].y),
          Offset(pathPoints[i+1].x, pathPoints[i+1].y),
          linePaint
      );
    }

    double endX = curPoint.x;
    double endY = curPoint.y;
    if (endX < 0) {
      endX = 0;
    } else if (endX > size.width) {
      endX = size.width;
    }
    if (endY < 0) {
      endY = 0;
    } else if (endY > size.height){
      endY = size.height;
    }

    canvas.drawLine(
        Offset(pathPoints[length - 1].x, pathPoints[length - 1].y),
        Offset(endX, endY),
        linePaint
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}