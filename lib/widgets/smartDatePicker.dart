import 'package:flutter/material.dart';

import '../utiles/util.dart';

Future<DateTime?> smartDateTimePicker(
    BuildContext context,TextEditingController controller ,{
      String mode = 'both', // 'date', 'time', or 'both'
    }) async {
  DateTime now = DateTime.now();
  DateTime? finalDateTime;

  if (mode == 'both') {
    //  Pick Date first
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (pickedDate == null) return null;

    //  Then pick Time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return null;

    finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  } else if (mode == 'date') {
    //  Only Date picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (pickedDate == null) return null;
    finalDateTime = pickedDate;
  } else if (mode == 'time') {
    //  Only Time picker
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return null;

    finalDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  } else {
    throw ArgumentError("Invalid mode: use 'date', 'time', or 'both'");
  }

  //  Format and set text
  late String formatted;

  switch (mode) {
    case "both":
      formatted = getDateAndTimeFormatDate(finalDateTime);
    case "date":
      formatted = getDateFormatDate(finalDateTime);
    case "time":
      formatted = getTimeFormatDate(finalDateTime);
  }
  controller.text = formatted;

  return finalDateTime;
}