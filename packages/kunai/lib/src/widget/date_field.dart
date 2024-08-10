import 'package:flutter/material.dart';
import 'package:kunai/kunai.dart';

enum DateFieldFormat {
  localYearAndMonth,
  all,
}

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    this.onChange,
    this.value,
    this.includeTime = false,
    this.firstDate,
    this.lastDate,
    this.format = DateFieldFormat.all,
    this.separatorSize = 2,
  });

  final ValueChanged<DateTime?>? onChange;
  final bool includeTime;
  final DateTime? value;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final DateFieldFormat format;
  final double separatorSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () async {
            if (!includeTime) {
              onChange?.call(
                await showDatePicker(
                  context: context,
                  firstDate: firstDate ??
                      DateTime.now().subtract(const Duration(days: 366)),
                  lastDate: lastDate ?? DateTime(2034),
                ),
              );
              return;
            }

            DateTime? mDate = await showDatePicker(
              context: context,
              firstDate: firstDate ??
                  DateTime.now().subtract(const Duration(days: 366)),
              lastDate: lastDate ?? DateTime(2034),
            );
            if (mDate != null) {
              TimeOfDay? mTime = await showTimePicker(
                // ignore: use_build_context_synchronously
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (mTime != null) {
                onChange?.call(
                    mDate.copyWith(hour: mTime.hour, minute: mTime.minute));
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            child: Text(value == null
                ? '00/00/00'
                : (format == DateFieldFormat.all
                    ? value.toString()
                    : value!.toLocalStringWithoutDay(context))),
          ),
        ),
        Separator(
          width: double.infinity,
          size: separatorSize,
        ),
      ],
    );
  }
}
