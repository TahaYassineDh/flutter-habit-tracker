import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/services/dialog_service.dart';
import '../services/logic.dart';

class HabitControls extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback setState;
  final TextEditingController myControllerHabitName;
  final TextEditingController myControllerGoal;
  final List<Habit> habits;

  const HabitControls({
    required this.selectedDate,
    required this.habits,
    required this.setState,
    required this.myControllerHabitName,
    required this.myControllerGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // 🔄 Reset Button
        ElevatedButton.icon(
          onPressed: () => resetHabit(setState, habits, selectedDate),
          icon: Icon(Icons.refresh, color: Colors.white),
          label: Text('Reset', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrangeAccent, // Soft red color
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),

        // 📅 Date Selector
        GestureDetector(
          onTap: () {
            selectDate(context, setState, selectedDate, habits);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent, // Lighter blue for better contrast
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  formatDate(selectedDate),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),

        // ➕ Add Button
        ElevatedButton.icon(
          onPressed: () {
            dialogFun(
                addHabit: addHabit,
                context: context,
                myControllerGoal: myControllerGoal,
                myControllerHabitName: myControllerHabitName);
          },
          icon: Icon(Icons.add, color: Colors.white),
          label: Text('Add', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Subtle green
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
