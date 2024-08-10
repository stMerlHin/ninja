import 'package:flutter/material.dart';
import 'package:kunai/l10n/localizations_ext.dart';

import 'methods.dart' as methods;

extension WidgetListCenteriserExt on List<Widget> {
  List<Widget> center() {
    List<Widget> l = [];
    forEach((element) {
      l.add(Center(
        child: element,
      ));
    });
    return l;
  }

  List<Widget> applyPadding(EdgeInsetsGeometry padding) {
    List<Widget> l = [];
    forEach((element) {
      l.add(Padding(
        padding: padding,
        child: element,
      ));
    });
    return l;
  }

  List<Widget> onPressed(VoidCallback onPressed) {
    List<Widget> l = [];
    forEach((element) {
      l.add(TextButton(
        onPressed: onPressed,
        child: element,
      ));
    });
    return l;
  }

  List<Widget> onTap(VoidCallback onTap) {
    List<Widget> l = [];
    forEach((element) {
      l.add(InkWell(
        onTap: onTap,
        child: element,
      ));
    });
    return l;
  }
}

extension ListContentSplitExt on List {
  String toSplitableString([String pattern = "/"]) {
    if (isNotEmpty) {
      String value = this[0];
      for (int i = 1; i < length; i++) {
        value += pattern + this[i].toString();
      }
      return value;
    }
    return "";
  }

  List<List> split([int value = 10]) {
    List<List> l = [];

    if (length <= value) {
      l.add(this);
      return l;
    }

    List l2 = [];
    forEach((element) {
      if (l2.length < value) {
        l2.add(element);
      } else {
        l.add([...l2]);
        l2.clear();
        l2.add(element);
      }
    });
    l.add(l2);
    return l;
  }
}

extension CenteriserExt on Widget {
  Widget center() {
    return Center(
      child: this,
    );
  }
}

extension IntExt on int {
  String toStringWith0() {
    if (this <= 9) {
      return '0$this';
    } else {
      return '$this';
    }
  }
}

extension DateTimeExt on DateTime {
  bool operator <(DateTime other) {
    return toUtc().microsecondsSinceEpoch <
        other.toUtc().microsecondsSinceEpoch;
  }

  bool operator >(DateTime other) {
    return other < this;
  }

  String toBString([String separator = '-']) {
    return '${day.toStringWith0()}$separator${month.toStringWith0()}'
        '$separator${year.toStringWith0()} ${hour.toStringWith0()}:'
        '${minute.toStringWith0()}';
  }

  String toLocalString(BuildContext context) {
    return '${day.toStringWith0()} ${toLocalMonth(context)} $year';
  }

  String toLocalStringWithoutDay(BuildContext context) {
    return '${toLocalMonth(context)} $year';
  }

  String toLocalStringWithHour(BuildContext context) {
    return '${toLocalString(context)} '
        '${context.kunaiL10n.at.toLowerCase()} '
        '${hour.toStringWith0()}:${minute.toStringWith0()}';
  }

  String toSlashedString([String separator = '/']) {
    return '${day.toStringWith0()}$separator${month.toStringWith0()}'
        '$separator${year.toStringWith0().substring(2, 4)}';
  }

  String toDatabaseDateFormatString([String separator = '-']) {
    return '$year$separator$month$separator$day';
  }

  String get hourAndMinuteWithZero => '${hour.toStringWith0()}:${minute.toStringWith0()}';

  DateTime get lastWeekFirstDayDate {
    DateTime begin;
    switch (weekday) {
      case 1:
        begin = subtract(const Duration(days: 7));
      case 2:
        begin = subtract(const Duration(days: 8));
      case 3:
        begin = subtract(const Duration(days: 9));
      case 4:
        begin = subtract(const Duration(days: 10));
      case 5:
        begin = subtract(const Duration(days: 11));
      case 6:
        begin = subtract(const Duration(days: 12));
      default:
        begin = subtract(const Duration(days: 13));
    }
    return begin.copyWith(hour: 00, minute: 01);
  }

  DateTime plusMonth(int value) {
    assert(value >= 0);
    return _plusMonth(value);
  }

  DateTime _plusMonth(int value) {
    int newMonth = month + value;
    int newDay = day;
    int newYear = year;
    if (newMonth > 12) {
      newYear++;
      return DateTime(newYear, month, day)._plusMonth(newMonth - 12 - month);
    } else {
      if (newMonth == 2) {
        if (day > 28) {
          newDay = 28;
        }
      } else if (newMonth % 2 == 0 && newMonth != 8) {
        if (day > 30) {
          newDay = 30;
        }
      }
    }
    return DateTime(newYear, newMonth, newDay);
  }

  //TODO use dart 3 format
  String toLocalMonth(BuildContext context) {
    switch (month) {
      case DateTime.january:
        return context.kunaiL10n.january;
      case DateTime.february:
        return context.kunaiL10n.february;
      case DateTime.march:
        return context.kunaiL10n.march;
      case DateTime.april:
        return context.kunaiL10n.april;
      case DateTime.may:
        return context.kunaiL10n.may;
      case DateTime.june:
        return context.kunaiL10n.june;
      case DateTime.july:
        return context.kunaiL10n.july;
      case DateTime.august:
        return context.kunaiL10n.august;
      case DateTime.september:
        return context.kunaiL10n.september;
      case DateTime.october:
        return context.kunaiL10n.october;
      case DateTime.november:
        return context.kunaiL10n.november;
      default:
        return context.kunaiL10n.december;
    }
  }

  String toLocalWeekDay(BuildContext context) {
    switch (weekday) {
      case 1:
        return context.kunaiL10n.monday;
      case 2:
        return context.kunaiL10n.tuesday;
      case 3:
        return context.kunaiL10n.wednesday;
      case 4:
        return context.kunaiL10n.thursday;
      case 5:
        return context.kunaiL10n.friday;
      case 6:
        return context.kunaiL10n.saturday;
      default:
        return context.kunaiL10n.sunday;
    }
  }

  static String parseLocalDay(int weekday, BuildContext context) {
    switch (weekday) {
      case 1:
        return context.kunaiL10n.monday;
      case 2:
        return context.kunaiL10n.tuesday;
      case 3:
        return context.kunaiL10n.wednesday;
      case 4:
        return context.kunaiL10n.thursday;
      case 5:
        return context.kunaiL10n.friday;
      case 6:
        return context.kunaiL10n.saturday;
      default:
        return context.kunaiL10n.sunday;
    }
  }
}

extension ThemeModeExt on ThemeMode {
  static ThemeMode parse(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String toCString() {
    switch (this) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }
}

extension StateNavigationExt on State {
  // Launch new page
  Future nextPage(Widget page) async {
    await methods.nextPage(context, page);
  }

  ///Go back to the previous page
  void previousPage() async {
    methods.previousPage(context);
  }

  Color get primaryColor => context.primaryColor;
  Color get onPrimary => context.onPrimary;
  Color get secondary => context.secondary;
  Color get onSecondary => context.onSecondary;
  Color get tertiary => context.tertiary;
  Color get onTertiary => context.onTertiary;
  Color get primaryContainer => context.primaryContainer;
  Color get onPrimaryContainer => context.onPrimaryContainer;
  ThemeData get themeData => context.themeData;
}

extension ContextColor on BuildContext {
  Color get primaryColor => methods.themePrimaryColor(this);
  Color get onPrimary => themeData.colorScheme.onPrimary;
  Color get secondary => themeData.colorScheme.secondary;
  Color get onSecondary => themeData.colorScheme.onSecondary;
  Color get tertiary => themeData.colorScheme.tertiary;
  Color get onTertiary => themeData.colorScheme.onTertiary;
  Color get primaryContainer => themeData.colorScheme.primaryContainer;
  Color get onPrimaryContainer => themeData.colorScheme.onPrimaryContainer;
  ThemeData get themeData => Theme.of(this);
}
