import 'package:flutter/material.dart';
import 'package:gesture_recognition/line_view.dart';
import 'package:gesture_recognition/point_view.dart';
import 'package:gesture_recognition/point.dart';

class GestureView extends StatefulWidget {

  final double size;
  final selectColor;
  final unSelectColor;
  final double ringWidth;
  final double ringRadius;
  final double circleRadius;
  final double lineWidth;
  final bool showUnSelectRing;
  final bool immediatelyClear;
  List<Point> points;
  final Function() onPanDown;
  final Function(List<int>) onPanUp;

  GestureView({
    Key key,
    @required this.size,
    this.selectColor = Colors.blue,
    this.unSelectColor = Colors.grey,
    this.ringWidth = 4,
    this.ringRadius = 30,
    this.showUnSelectRing = true,
    this.circleRadius = 20,
    this.lineWidth = 6,
    this.onPanUp,
    this.onPanDown,
    this.immediatelyClear = false
  }): super(key: key){
    // 减少刷新频率
    points = [];
    final realRingSize = this.ringRadius + this.ringWidth/2;
    final gapWidth = size/6 - realRingSize;
    for (int i = 0 ; i < 9 ; i++) {
      double x = gapWidth + realRingSize;
      double y = gapWidth + realRingSize;
      points.add(Point(
          x: (1+i%3*2)*x,
          y: (1+i~/3*2)*y,
          position: i
      ));
    }
  }

  @override
  State<StatefulWidget> createState() {
    return GestureState(
        size: this.size,
        ringWidth: this.ringWidth,
        ringRadius: this.ringRadius,
        showUnSelectRing: this.showUnSelectRing,
        circleRadius: this.circleRadius,
        selectColor: this.selectColor,
        unSelectColor: this.unSelectColor,
        points: this.points,
        lineWidth: this.lineWidth,
        onPanDown: this.onPanDown,
        onPanUp: this.onPanUp,
        immediatelyClear: this.immediatelyClear
    );
  }
}

class GestureState extends State<GestureView> {

  final double size;
  final double ringWidth;
  final double ringRadius;
  final bool showUnSelectRing;
  final double circleRadius;
  Color selectColor; // open only
  final Color unSelectColor;
  final double lineWidth;
  final List<Point> points;
  final Function() onPanDown;
  final Function(List<int>) onPanUp;
  final List<Point> pathPoints = [];
  double realRadius = 0;
  Point curPoint;
  final bool immediatelyClear;

  GestureState({
    @required this.size,
    this.selectColor,
    this.unSelectColor,
    this.ringWidth,
    this.ringRadius,
    this.showUnSelectRing,
    this.circleRadius,
    this.points,
    this.lineWidth,
    this.onPanDown,
    this.onPanUp,
    this.immediatelyClear,
  });

  @override
  void initState() {
    super.initState();
    realRadius = this.ringRadius+this.ringWidth/2;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: CustomPaint(
            size: Size(this.size, this.size),
            painter: PointView(
                ringWidth: this.ringWidth,
                ringRadius: this.ringRadius,
                showUnSelectRing: this.showUnSelectRing,
                circleRadius: this.circleRadius,
                selectColor: this.selectColor,
                unSelectColor: this.unSelectColor,
                points: points
            ),
          ),
        ),
        GestureDetector(
          child: CustomPaint(
            size: Size(this.size, this.size),
            painter: LineView(
                pathPoints: this.pathPoints,
                selectColor: this.selectColor,
                lineWidth: this.lineWidth,
                curPoint: this.curPoint
            ),
          ),
          onPanDown: this._onPanDown,
          onPanUpdate: (DragUpdateDetails e) => this._onPanUpdate(e,context),
          onPanEnd: (DragEndDetails e) => this._onPanEnd(e,context)
        )
      ],
    );
  }

  _onPanDown(DragDownDetails e) {
    this._clearAllData();
    if (this.onPanDown != null) this.onPanDown();
  }

  _onPanUpdate(DragUpdateDetails e,BuildContext context) {

    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(e.globalPosition);
    _slideDealt(offset);
    setState(() {
      curPoint = Point(x: offset.dx, y: offset.dy,position: -1);
    });
  }

  _onPanEnd(DragEndDetails e,BuildContext context) {

    if (pathPoints.length > 0) {
      setState(() {
        curPoint = pathPoints[pathPoints.length - 1];
      });
      if (this.onPanUp != null) {
        List<int> items = pathPoints.map((item) => item.position).toList();
        this.onPanUp(items);
      }
      if (this.immediatelyClear) this._clearAllData(); //clear data
    }
  }

  _slideDealt(Offset offSet) {
    int xPosition = -1;
    int yPosition = -1;
    for (int i = 0 ; i < 3 ; i++) {
      if (xPosition == -1 && points[i].x+realRadius >= offSet.dx && offSet.dx >= points[i].x-realRadius) {
        xPosition = i;
      }
      if (yPosition == -1 && points[i*3].y+realRadius >= offSet.dy && offSet.dy >= points[i*3].y - realRadius) {
        yPosition = i;
      }
    }
    if (xPosition == -1 || yPosition == -1) return;
    int position = yPosition*3+xPosition;

    if (!points[position].isSelect) {
      points[position].isSelect = true;
      pathPoints.add(points[position]);
    }
  }

  _clearAllData() {
    for (int i = 0 ; i < 9 ; i++) {
      points[i].isSelect = false;
    }
    pathPoints.clear();
    setState(() {});
  }

}