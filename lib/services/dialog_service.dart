import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void dialogFun({context, myControllerHabitName, myControllerGoal, addHabit}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            child: Container(
                height: 200,
                width: 300,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: myControllerHabitName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Habit name.',
                        ),
                      ),
                      TextField(
                        controller: myControllerGoal,
                        decoration: InputDecoration(labelText: "Goal: "),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          SizedBox(width: 8),
                          ElevatedButton(
                              onPressed: () {
                                addHabit();
                                Navigator.pop(context);
                              },
                              child: Text('Add')),
                        ],
                      ),
                    ],
                  ),
                )),
          ));
}
