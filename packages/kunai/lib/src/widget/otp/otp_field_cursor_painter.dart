import 'package:flutter/material.dart';

class OTPFieldCursorPainter extends CustomPainter {
  OTPFieldCursorPainter(
      {this.cursorColor = Colors.black, this.cursorWidth = 2});

  final Color cursorColor;
  final double cursorWidth;

  @override
  void paint(Canvas canvas, Size size) {
    const p1 = Offset(0, 0);
    final p2 = Offset(0, size.height);
    final paint = Paint()
      ..color = cursorColor
      ..strokeWidth = cursorWidth;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
