
import 'package:flutter/services.dart';

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'[a-zA-Z0-9.*%±]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}');
  return emailRegex.hasMatch(email);
}

String formattedNumber(num number, {String separator = ' '}) {
  num nNumber = number.toInt() == number ? number.toInt() : number;
  String signValue = nNumber >= 0 ? '' : '-';
  if (signValue.isNotEmpty) {
    nNumber = nNumber * -1;
  }
  final numberStrings = nNumber.toString().split('.');
  String tail = '';
  String tailSeparator = '';
  String numberStr = numberStrings.first;
  if (numberStrings.length == 2) {
    tail = numberStrings.last;
    tailSeparator = separator == '.' ? ',' : '.';
  }
  String formattedNumber = '';
  int counter = 0;

  for (int i = numberStr.length - 1; i >= 0; i--) {
    formattedNumber = numberStr[i] + formattedNumber;
    counter++;

    if (counter == 3 && i != 0) {
      formattedNumber = separator + formattedNumber;
      counter = 0;
    }
  }

  return signValue + formattedNumber + tailSeparator + tail;
}

class PatternedTextInputFormatter extends TextInputFormatter {
  final String sample;
  final String separator;

  const PatternedTextInputFormatter({
    required this.sample,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > sample.length) return oldValue;
        if (newValue.text.length < sample.length &&
            sample[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
            '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      } else {
        if (newValue.text.endsWith(separator)) {
          return TextEditingValue(
            text:
            '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }

    return newValue;
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  final String separator;

  const NumberTextInputFormatter({this.separator = ' '});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    if (newValue.text.length > oldValue.text.length) {
      final value = num.tryParse(newValue.text.replaceAll(separator, ''));
      if (value != null) {
        String newString = formattedNumber(value, separator: separator);
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(
            offset:
            newValue.selection.end +
                newString.length -
                newValue.text.length,
          ),
        );
      }
    } else if (newValue.text.length < oldValue.text.length) {
      final value = num.tryParse(newValue.text.replaceAll(separator, ''));
      if (value != null) {
        // final newString = newValue.text.substring(0, newValue.text.length -1);
        String newString = formattedNumber(value, separator: separator);
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(
            offset:
            newValue.selection.end +
                newString.length -
                newValue.text.length,
          ),
        );
      }
    }

    return newValue;
  }
}
