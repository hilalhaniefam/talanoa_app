import 'package:flutter/material.dart';

Map formValue = {'type': '', 'pax': '', 'note': TextEditingController()};

Color setTypeButtonColor(type) {
  if (formValue['type'] == type) return Colors.white;
  return Colors.transparent;
}

Color setPaxButtonColor(pax) {
  if (formValue['pax'] == pax) return Colors.white;
  return Colors.transparent;
}

String formatDate(DateTime date) {
  String day = date.day.toString();
  if (day.length < 2) day = '0' + day;

  String month = date.month.toString();
  if (month.length < 2) month = '0' + month;

  String year = date.year.toString();
  return "$day/$month/$year";
}

String formatTime(TimeOfDay time) {
  String hour = time.hour.toString();
  if (hour.length < 2) hour = '0' + hour;

  String minute = time.minute.toString();
  if (minute.length < 2) minute = '0' + minute;
  return "$hour : $minute";
}
