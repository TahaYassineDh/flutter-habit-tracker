import 'dart:math';
import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/logic.dart';

class HabitCard extends StatefulWidget {
  final DateTime selectedDate;
  final List<Habit> habits;
  final int index;
  final VoidCallback setState;
  const HabitCard({
    Key? key,
    required this.setState,
    required this.selectedDate,
    required this.habits,
    required this.index,
  }) : super(key: key);
  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  double opacityValue = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100) * widget.index, () {
      setState(() {
        opacityValue = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double progressWidth = (widget.habits[widget.index].streak /
            max(widget.habits[widget.index].goal, 1)) *
        MediaQuery.of(context).size.width;

    return TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(seconds: 2),
        builder: (BuildContext context, value, Widget? child) {
          return AnimatedOpacity(
            opacity: opacityValue,
            duration: Duration(milliseconds: 1000),
            curve: Curves.linear,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Container(
                    height: 100,
                    width: progressWidth,
                    decoration: BoxDecoration(
                      color: Colors
                          .primaries[widget.habits[widget.index].generatedColor]
                          .withValues(alpha: 0.5), // Slight transparency
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                // Habit Info
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3), // Dark overlay
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: widget.habits[widget.index]
                                    .logs[widget.selectedDate]!
                                ? Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                            onPressed: () {
                              toggleHabit(
                                  widget.habits[widget.index],
                                  widget.setState,
                                  widget.selectedDate,
                                  widget.habits);
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.habits[widget.index].name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => deleleHabit(widget.index,
                                          widget.setState, widget.habits),
                                      icon: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.local_fire_department,
                                            color: Colors.orangeAccent,
                                            size: 20),
                                        SizedBox(width: 4),
                                        Text(
                                            '${widget.habits[widget.index].streak} days',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.flag,
                                            color: Colors.blueAccent, size: 20),
                                        SizedBox(width: 4),
                                        Text(
                                            '${widget.habits[widget.index].goal} days',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
