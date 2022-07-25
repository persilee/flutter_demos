import 'dart:ui';
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

num degToRad(num deg) => deg * (math.pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / math.pi);

class CustomCirclePainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color mainColor;
  final Color secondaryColor;
  final AnimationController controller;

  CustomCirclePainter(
      {required this.percentage,
      required this.controller,
      this.mainColor = const Color(0xff3FB7D7),
      this.secondaryColor = Colors.white,
      this.strokeWidth = 22.0})
      : super(repaint: controller);

  late double effectiveRadius;

  Radius get _circularRadius => Radius.circular(effectiveRadius);

  @override
  void paint(Canvas canvas, Size size) {
    final double _width = size.width;
    final double _height = size.height;
    Offset center = Offset(size.width / 2, size.height / 2); //  坐标中心
    effectiveRadius = math.min(size.width / 2, size.height / 2);
    double strokeWidth = this.strokeWidth <= 4 ? 1 : this.strokeWidth - 4;
    double percentage; // 主百分比
    double percentageOther; // 次百分比
    double arcAngle; // 主弧度
    double arcAngleOther; // 次弧度
    num deg; // 间隙角度
    double pathRad; // 开始点的主弧度
    double path2Rad; // 开始点的次弧度
    bool isDraw = true;
    if (this.percentage >= (100 - 7) && this.percentage < 98) {
      percentage = 92.0;
      percentageOther = 100 - percentage - 7;
      arcAngle = 2 * math.pi * ((percentage - 7) / 100);
      arcAngleOther = 2 * math.pi * ((percentageOther) / 100);
      deg = radToDeg(2 * math.pi * (7 / 100));
      pathRad = degToRad(radToDeg(arcAngleOther) / 2 + deg).toDouble();
      path2Rad = degToRad(360 - radToDeg(arcAngleOther) / 2).toDouble();
    } else if (this.percentage >= 98) {
      percentage = 100.0;
      percentageOther = 0;
      arcAngle = 2 * math.pi;
      arcAngleOther = 0;
      pathRad = degToRad(360).toDouble();
      path2Rad = degToRad(0).toDouble();
      isDraw = false;
    } else {
      percentage = this.percentage;
      percentageOther = 100 - percentage - 7;
      arcAngle = 2 * math.pi * ((percentage - 7) / 100);
      arcAngleOther = 2 * math.pi * ((percentageOther) / 100);
      deg = radToDeg(2 * math.pi * (7 / 100));
      pathRad = degToRad(radToDeg(arcAngleOther) / 2 + deg).toDouble();
      path2Rad = degToRad(360 - radToDeg(arcAngleOther) / 2).toDouble();
    }

    Paint paint = Paint()
      ..color = this.mainColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round;
    Paint paintShadow = Paint()
      ..color = Colors.black87.withOpacity(0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, this.strokeWidth / 2);

    Paint paint2 = Paint()
      ..color = this.secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Paint paint2Shadow = Paint()
      ..color = Colors.black87.withOpacity(0.26)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, strokeWidth / 2);

    Path path = Path()
      ..addArc(Rect.fromCircle(center: center, radius: effectiveRadius / 2),
          pathRad, arcAngle);
    PathMetric metric = path.computeMetrics().single;
    Path path2 = Path()
      ..addArc(Rect.fromCircle(center: center, radius: effectiveRadius / 2),
          path2Rad, arcAngleOther);
    PathMetric? metric2 = isDraw ? path2.computeMetrics().single : null;
    canvas.drawPath(
        metric.extractPath(0, metric.length * controller.value), paint);
    canvas.drawPath(
        metric.extractPath(0, metric.length * controller.value), paintShadow);
    if (isDraw) {
      canvas.drawPath(
          metric2!.extractPath(0, metric2.length * controller.value), paint2);
      canvas.drawPath(metric2.extractPath(0, metric2.length * controller.value),
          paint2Shadow);
    }
  }

  @override
  bool shouldRepaint(covariant CustomCirclePainter oldDelegate) {
    return true;
  }
}

class DoubleCirclePainter extends CustomPainter {
  final double percentage;
  final AnimationController controller;

  DoubleCirclePainter({required this.percentage, required this.controller})
      : super(repaint: controller);

  late double effectiveRadius;

  Radius get _circularRadius => Radius.circular(effectiveRadius);

  @override
  void paint(Canvas canvas, Size size) {
    final double _width = size.width;
    final double _height = size.height;
    Offset center = Offset(size.width / 2, size.height / 2); //  坐标中心
    effectiveRadius = math.min(size.width / 2, size.height / 2);

    double startAngle = degToRad(270).toDouble(); // 弧度的起始位置
    double arcAngle = 2 * math.pi * (percentage / 100); // 弧度的终点位置

    // 绘制线性渐变色
    var gradient = ui.Gradient.linear(
      Offset(
        _width / 2,
        _height / 2 - effectiveRadius,
      ),
      Offset(_width / 2, _height / 2 + effectiveRadius),
      [
        const Color(0xFFD0C877),
        const Color(0xFFEFD8A7),
        const Color(0xFF725E35),
        const Color(0xFFBAA270),
      ],
      [0, 0.15, 0.96, 1],
    );

    Paint paint = Paint()
      ..color = const Color(0xff02294E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0
      ..strokeCap = StrokeCap.round;

    Paint paint2 = Paint()
      ..shader = gradient
      ..color = const Color(0xffEFD8A7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;

    Paint paintShadow = Paint()
      ..color = Colors.white.withOpacity(0.46)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);

    Path path = Path()
      ..moveTo(_width / 2, _height / 2)
      ..addOval(Rect.fromCircle(center: center, radius: effectiveRadius / 2));
    Path path2 = Path()
      ..addArc(Rect.fromCircle(center: center, radius: effectiveRadius / 2),
          startAngle, arcAngle);

    canvas.drawPath(path, paint);
    canvas.drawCircle(center, (effectiveRadius - 16) / 2, paintShadow);
    if (percentage != 0) {
      PathMetric metric = path2.computeMetrics().single;
      canvas.drawPath(
          metric.extractPath(0, metric.length * controller.value), paint2);
    }
  }

  @override
  bool shouldRepaint(covariant DoubleCirclePainter oldDelegate) {
    return true;
  }
}
