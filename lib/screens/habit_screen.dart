import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/habit_controls.dart';

import '../models/habit.dart';
import '../widgets/habit_widget.dart';

import '../services/logic.dart';

List<Habit> habits = [];

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  DateTime selectedDate = DateTime.now();
  final myControllerHabitName = TextEditingController();
  final myControllerGoal = TextEditingController();

  @override
  void initState() {
    loadData(setState, habits, selectedDate);
    updateLogs(setState, habits, selectedDate);
    super.initState();
  }

  @override
  void dispose() {
    myControllerGoal.dispose();
    myControllerHabitName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          title: Text('Habit Tracker',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.black,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFF121212), Color(0xFF1E1E1E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: HabitControls(
                  habits: habits,
                  setState: () => setState,
                  selectedDate: selectedDate,
                  myControllerGoal: myControllerGoal,
                  myControllerHabitName: myControllerHabitName,
                )),
            ListView.builder(
                shrinkWrap: true,
                itemCount: habits.length,
                itemBuilder: (BuildContext context, int index) {
                  return (habits[index].logs[selectedDate] != null)
                      ? HabitCard(
                          setState: () => setState,
                          selectedDate: selectedDate,
                          habits: habits,
                          index: index)
                      : null;
                }),
          ],
        ),
      ),
    );
  }
}
