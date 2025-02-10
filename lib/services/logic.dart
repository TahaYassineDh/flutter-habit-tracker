import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveData(habits) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = json.encode(habits.map((h) => h.toJson()).toList());
  await prefs.setString('habits', jsonString);
}

void loadData(setState, habits, selectedDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? data = prefs.getString('habits');

  if (data != null) {
    List<dynamic> decoded = json.decode(data);
    setState(() {
      habits = decoded.map((h) => Habit.fromJson(h)).toList();
    });
  }
  updateLogs(setState, habits, selectedDate);
}

void addHabit(setState, habits, myControllerHabitName, myControllerGoal) {
  setState(() {
    habits.add(Habit(
      name: myControllerHabitName.text,
      goal: int.parse(myControllerGoal.text),
      streak: 0,
    ));
    saveData(habits);
  });
  myControllerHabitName.text = '';
  myControllerGoal.text = '';
}

void deleleHabit(int index, setState, habits) {
  setState(() {
    habits.removeAt(index);
  });
  saveData(habits);
}

void toggleHabit(Habit h, setState, selectedDate, habits) {
  DateTime previousDate = selectedDate.subtract(Duration(days: 1));

  setState(() {
    bool isCompleted = h.logs[selectedDate] ?? false;
    bool wasPreviousDayCompleted = h.logs[previousDate] ?? false;

    if (isCompleted) {
      h.logs[selectedDate] = false;
      if (h.streak > 0) h.streak--;
    } else {
      h.logs[selectedDate] = true;
      h.streak = wasPreviousDayCompleted ? h.streak + 1 : 1;
    }

    saveData(habits);
  });
}

void resetHabit(setState, habits, selectedDate) {
  setState(() {
    for (Habit h in habits) {
      h.logs[selectedDate] = false;
    }
    saveData(habits);
  });
}

void updateLogs(setState, habits, selectedDate) {
  setState(() {
    for (Habit h in habits) {
      if (h.logs[selectedDate] == null) {
        h.logs[selectedDate] = false;
        saveData(habits);
      }
    }
  });
}

Future<void> selectDate(
    BuildContext context, setState, selectedDate, habits) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2025),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
      updateLogs(setState, habits, selectedDate);
    });
  }
}

String formatDate(DateTime date) {
  return DateFormat('EEEE, MMM d').format(date); // Example: "Monday, Feb 5"
}
