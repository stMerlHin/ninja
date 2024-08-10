import 'package:flutter/material.dart';
import 'package:kunai/l10n/localizations_ext.dart';

class LaunchingPage extends StatelessWidget {
  const LaunchingPage({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child ??
          Center(
            child: Text(context.kunaiL10n.loading),
          ),
    );
  }
}
