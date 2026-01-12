
import 'package:flutter/material.dart';
import 'package:kunai/kunai.dart';
import 'package:kunai/l10n/localizations_ext.dart';

class ErrorActionWidget extends StatelessWidget {
  const ErrorActionWidget({super.key, this.errorMessage, required this.onPressed});

  final String? errorMessage;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errorMessage ?? context.kunaiL10n.anErrorHasOccurred),
        TextButton(onPressed: onPressed, child: Text(context.kunaiL10n.retry))
      ].center(),
    );
  }
}
