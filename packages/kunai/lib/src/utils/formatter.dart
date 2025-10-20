
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


class DecimalNumberTextInputFormatter extends TextInputFormatter {
  final String thousandsSeparator;
  final bool allowNegative;

  const DecimalNumberTextInputFormatter({
    this.thousandsSeparator = ' ',
    this.allowNegative = false,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // --- Étape 1 : filtrer les caractères autorisés ---
    final regExp = allowNegative
        ? RegExp('[^0-9.,$thousandsSeparator-]')
        : RegExp('[^0-9.,$thousandsSeparator]');
    String filtered = newValue.text.replaceAll(regExp, '');

    // Empêcher plusieurs séparateurs décimaux
    final decimalSeparators = RegExp(r'[.,]');
    final matches = decimalSeparators.allMatches(filtered);
    if (matches.length > 1) {
      // Si l'utilisateur essaie d'entrer un 2e séparateur décimal, on ignore.
      return oldValue;
    }

    // --- Étape 2 : identifier le séparateur décimal (point ou virgule) ---
    String? decimalSeparator;
    if (filtered.contains('.')) {
      decimalSeparator = '.';
    } else if (filtered.contains(',')) {
      decimalSeparator = ',';
    }

    // --- Étape 3 : séparer partie entière et partie décimale ---
    String integerPart = filtered;
    String decimalPart = '';

    if (decimalSeparator != null) {
      final parts = filtered.split(decimalSeparator);
      integerPart = parts[0];
      decimalPart = parts.length > 1 ? parts[1] : '';
    }

    // --- Étape 4 : supprimer les séparateurs existants et reformater ---
    final numericString = integerPart.replaceAll(thousandsSeparator, '');
    final value = num.tryParse(numericString);
    if (value == null) {
      return oldValue;
    }

    final formattedInteger = _formatWithSeparator(value.toInt());

    // --- Étape 5 : reconstruire le texte final ---
    String newText = formattedInteger;
    if (decimalSeparator != null && decimalPart.isNotEmpty) {
      newText += '$decimalSeparator$decimalPart';
    } else if (decimalSeparator != null &&
        filtered.endsWith(decimalSeparator)) {
      // Permettre de taper le séparateur à la fin (ex: "12," ou "12.")
      newText += decimalSeparator;
    }

    // --- Étape 6 : position du curseur ---
    final selectionOffset = newText.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionOffset),
    );
  }

  /// Formate la partie entière avec un séparateur des milliers
  String _formatWithSeparator(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      int positionFromEnd = str.length - i;
      buffer.write(str[i]);
      if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
        buffer.write(thousandsSeparator);
      }
    }
    return buffer.toString();
  }
}

class IntTextInputFormatter extends TextInputFormatter {
  final String thousandsSeparator;

  const IntTextInputFormatter({this.thousandsSeparator = ' '});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 🔒 Filtrer uniquement les chiffres et le séparateur
    final filtered = newValue.text.replaceAll(RegExp('[^0-9$thousandsSeparator]'), '');

    // Si on a supprimé des lettres, on met à jour le texte tout de suite
    if (filtered != newValue.text) {
      return TextEditingValue(
        text: filtered,
        selection: TextSelection.collapsed(offset: filtered.length),
      );
    }

    // Supprimer le séparateur pour conversion en nombre
    final numericString = filtered.replaceAll(thousandsSeparator, '');
    final value = int.tryParse(numericString);

    if (value == null) {
      // Si la saisie ne peut pas être convertie en nombre, on garde l'ancienne valeur
      return oldValue;
    }

    // Reformater le nombre
    final newString = formattedNumber(value, separator: thousandsSeparator);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length,
      ),
    );
  }
}
