// Don't forget to set a child foreground color to white
import 'package:flutter/material.dart';

class OTPGradient extends StatelessWidget {
  const OTPGradient({
    super.key,
    required this.child,
    required this.gradient,
  });

  final Widget child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) =>
      ShaderMask(shaderCallback: gradient.createShader, child: child);
}
