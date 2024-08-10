import '../../otp_field.dart';

class OTPDialogConfig {
  /// title of the [AlertDialog] while pasting the code. Default to [Paste Code]
  final String? dialogTitle;

  /// content of the [AlertDialog] while pasting the code. Default to ["Do you want to paste this code "]
  final String? dialogContent;

  /// Affirmative action text for the [AlertDialog]. Default to "Paste"
  final String? affirmativeText;

  /// Negative action text for the [AlertDialog]. Default to "Cancel"
  final String? negativeText;

  final OTPDialogBuilder? builder;

  /// The default dialog theme, should it be iOS or other(including web and Android)
  final OTPPinCodePlatform platform;
  OTPDialogConfig._internal({
    this.dialogContent,
    this.dialogTitle,
    this.affirmativeText,
    this.negativeText,
    this.builder,
    this.platform = OTPPinCodePlatform.other,
  });

  factory OTPDialogConfig({
    String? affirmativeText,
    String? dialogContent,
    String? dialogTitle,
    String? negativeText,
    OTPDialogBuilder? builder,
    OTPPinCodePlatform? platform,
  }) {
    return OTPDialogConfig._internal(
      affirmativeText: affirmativeText ?? "Paste",
      dialogContent: dialogContent ?? "Do you want to paste this code ",
      dialogTitle: dialogTitle ?? "Paste Code",
      negativeText: negativeText ?? "Cancel",
      builder: builder,
      platform: platform ?? OTPPinCodePlatform.other,
    );
  }
}

typedef OTPDialogBuilder = Future<void> Function(String);
