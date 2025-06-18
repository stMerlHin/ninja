
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kunai/l10n/localizations_ext.dart';

import '../../shuriken.dart';

void onAuthError({
  required FirebaseAuthException error,
  required BuildContext context,
  VoidCallback? onCredentialAlreadyLinked,
}) {
  if (error.code == 'network-request-failed') {
    // ignore: use_build_context_synchronously
    showConnexionErrorSnackBar(context);
    return;
  }
  if (error.code == 'credential-already-in-use') {
    if (onCredentialAlreadyLinked != null) {
      onCredentialAlreadyLinked.call();
      return;
    }
    snackBar(context, context.kunaiL10n.anErrorHappened, durationSeconds: 20);
  }
  if (error.code == 'too-many-requests') {
    snackBar(context, context.kunaiL10n.bannedMessage, durationSeconds: 20);
    return;
  }
  // ignore: use_build_context_synchronously
  snackBar(context, context.kunaiL10n.authenticationError);
}