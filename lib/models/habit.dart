import 'dart:math';

import 'package:flutter/material.dart';

class Habit {
  String name;
  int streak;
  int goal;
  int generatedColor = Random().nextInt(Colors.primaries.length);

  Map<DateTime, bool> logs = {};
  Habit({
    this.name = 'A habit',
    this.streak = 0,
    this.goal = 0,
  }) {
    logs = {DateTime.now(): false};
  }
  Map<String, dynamic> toJson() {
    // Convert logs (Map<DateTime, bool>) to a JSON-compatible format
    Map<String, bool> logsJson = {};
    logs.forEach((key, value) {
      logsJson[key.toIso8601String()] = value; // Convert DateTime to String
    });

    return {
      'name': name,
      'streak': streak,
      'goal': goal,
      'logs': logsJson,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    Map<DateTime, bool> logs = {};
    json['logs'].forEach((key, value) {
      logs[DateTime.parse(key)] = value;
    });

    return Habit(
      name: json['name'],
      streak: json['streak'],
      goal: json['goal'],
    )..logs = logs;
  }
}
