import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jouleslab/habit.dart';
import 'package:jouleslab/habit_card.dart';

class HabitList extends StatelessWidget {
  final List<Habit> listOfHabits;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  HabitList(this.listOfHabits,this.setData,this.flutterLocalNotificationsPlugin);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => HabitCard(listOfHabits[index],setData,flutterLocalNotificationsPlugin),
      itemCount: listOfHabits.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
