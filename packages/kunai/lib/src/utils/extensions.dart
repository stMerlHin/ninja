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

  @Deprecated('Use [surfaceColor] instead')
  Color get surface => context.surface;
  @Deprecated('Use onSurfaceColor instead')
  Color get onSurface => context.onSurface;
  @Deprecated('Use errorColor instead')
  Color get error => context.error;
  @Deprecated('Use onErrorColor instead')
  Color get onError => context.onError;
  @Deprecated('Use errorContainerColor instead')
  Color get errorContainer => context.errorContainer;
  @Deprecated('Use onErrorContainerColor instead')
  Color get onErrorContainer => context.onErrorContainer;
  Color get primaryColor => context.primaryColor;
  @Deprecated('Use onPrimaryColor instead')
  Color get onPrimary => context.onPrimary;
  @Deprecated('Use secondaryColor instead')
  Color get secondary => context.secondary;
  @Deprecated('Use onSecondaryColor instead')
  Color get onSecondary => context.onSecondary;
  @Deprecated('Use tertiaryColor instead')
  Color get tertiary => context.tertiary;
  @Deprecated('Use onTertiaryColor instead')
  Color get onTertiary => context.onTertiary;
  @Deprecated('Use primaryContainerColor instead')
  Color get primaryContainer => context.primaryContainer;
  @Deprecated('Use onPrimaryColor instead')
  Color get onPrimaryContainer => context.onPrimaryContainer;

  Color get surfaceColor => context.surfaceColor;
  Color get onSurfaceColor => context.onSurfaceColor;
  Color get errorColor => context.errorColor;
  Color get onErrorColor => context.onErrorColor;
  Color get errorContainerColor => context.errorContainerColor;
  Color get onErrorContainerColor => context.onErrorContainerColor;
  Color get primaryColorColor => context.primaryColor;
  Color get onPrimaryColor => context.onPrimaryColor;
  Color get secondaryColor => context.secondaryColor;
  Color get onSecondaryColor => context.onSecondaryColor;
  Color get tertiaryColor => context.tertiaryColor;
  Color get onTertiaryColor => context.onTertiaryColor;
  Color get primaryContainerColor => context.primaryContainerColor;
  Color get onPrimaryContainerColor => context.onPrimaryContainerColor;
  ThemeData get themeData => context.themeData;
}

extension ContextColor on BuildContext {
  @Deprecated('Use [surfaceColor] instead')
  Color get surface => themeData.colorScheme.surface;
  @Deprecated('Use onSurfaceColor instead')
  Color get onSurface => themeData.colorScheme.onSurface;
  @Deprecated('Use errorColor instead')
  Color get error => themeData.colorScheme.error;
  @Deprecated('Use onErrorColor instead')
  Color get onError => themeData.colorScheme.onError;
  @Deprecated('Use errorContainerColor instead')
  Color get errorContainer => themeData.colorScheme.errorContainer;
  @Deprecated('Use onErrorContainerColor instead')
  Color get onErrorContainer => themeData.colorScheme.onErrorContainer;
  Color get primaryColor => themeData.colorScheme.primary;
  @Deprecated('Use onPrimaryColor instead')
  Color get onPrimary => themeData.colorScheme.onPrimary;
  @Deprecated('Use secondaryColor instead')
  Color get secondary => themeData.colorScheme.secondary;
  @Deprecated('Use onSecondaryColor instead')
  Color get onSecondary => themeData.colorScheme.onSecondary;
  @Deprecated('Use tertiaryColor instead')
  Color get tertiary => themeData.colorScheme.tertiary;
  @Deprecated('Use onTertiaryColor instead')
  Color get onTertiary => themeData.colorScheme.onTertiary;
  @Deprecated('Use primaryContainerColor instead')
  Color get primaryContainer => themeData.colorScheme.primaryContainer;
  @Deprecated('Use onPrimaryContainerColor instead')
  Color get onPrimaryContainer => themeData.colorScheme.onPrimaryContainer;

  Color get surfaceColor => themeData.colorScheme.surface;
  Color get onSurfaceColor => themeData.colorScheme.onSurface;
  Color get errorColor => themeData.colorScheme.error;
  Color get onErrorColor => themeData.colorScheme.onError;
  Color get errorContainerColor => themeData.colorScheme.errorContainer;
  Color get onErrorContainerColor => themeData.colorScheme.onErrorContainer;
  Color get onPrimaryColor => themeData.colorScheme.onPrimary;
  Color get secondaryColor => themeData.colorScheme.secondary;
  Color get onSecondaryColor => themeData.colorScheme.onSecondary;
  Color get tertiaryColor => themeData.colorScheme.tertiary;
  Color get onTertiaryColor => themeData.colorScheme.onTertiary;
  Color get primaryContainerColor => themeData.colorScheme.primaryContainer;
  Color get onPrimaryContainerColor => themeData.colorScheme.onPrimaryContainer;
  ThemeData get themeData => Theme.of(this);
}
