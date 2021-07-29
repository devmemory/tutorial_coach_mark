import 'dart:math';

import 'package:flutter/material.dart';

class LightPaint extends CustomPainter {
  final double progress;
  final Offset positioned;
  final double sizeCircle;
  final Color colorShadow;
  final double opacityShadow;
  final bool? drawCircle;

  late Paint _paintFocus;

  LightPaint(
    this.progress,
    this.positioned,
    this.sizeCircle, {
    this.drawCircle,
    this.colorShadow = Colors.black,
    this.opacityShadow = 0.8,
  }) : assert(opacityShadow >= 0 && opacityShadow <= 1) {
    _paintFocus = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawColor(colorShadow.withOpacity(opacityShadow), BlendMode.dstATop);

    if (drawCircle!) {
      var maxSize = max(size.width, size.height);

      double radius = maxSize * (1 - progress) + sizeCircle;

      canvas.drawCircle(positioned, radius, _paintFocus);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(LightPaint oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
