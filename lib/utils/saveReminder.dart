import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yuva_again/models/reminders.dart';

void saveReminder(
    String name, DateTime date, bool getNotified, String category, bool done) {
  final reminder = Reminders()
    ..name = name
    ..date = date
    ..getNotified = getNotified
    ..category = category
    ..done = done;
  final box = Hive.box<Reminders>('reminders');
  box.add(reminder);
}
