import 'package:flutter/material.dart';

class Point {
  double x;
  double y;
  bool isSelect = false;
  int position;

  Point({
    @required this.x,
    @required this.y,
    @required this.position
  });
}