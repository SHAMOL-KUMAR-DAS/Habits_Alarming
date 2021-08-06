import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:jouleslab/repository.dart';
import 'package:jouleslab/habit.dart';
import 'package:jouleslab/notifications.dart';

class HabitCard extends StatelessWidget {

  final Habit habit;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  HabitCard(this.habit,this.setData,this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {

    final bool isEnd = DateTime.now().millisecondsSinceEpoch > habit.time;

    return Card(
        elevation: 0.0,
        margin: EdgeInsets.symmetric(vertical: 7.0),
        color: Colors.white,
        child: ListTile(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onLongPress: () =>
                _showDeleteDialog(context, habit.name, habit.id, habit.notifyId),
            contentPadding:
            EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            title: Text(
              habit.name,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.black,
                  fontSize: 20.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${habit.description}",
              style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(habit.time)),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                ),
              ],
            ),
            leading: Container(
              width: 60.0,
              height: 60.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        isEnd ? Colors.white : Colors.transparent,
                        BlendMode.saturation),
                    child: Image.asset(
                        "assets/images/view.png"
                    )
                ),
              ),
            )));
  }



  void _showDeleteDialog(BuildContext context, String habitName, int habitId, int notifyId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Delete ?"),
          content: Text("Are you sure to delete $habitName habit?"),
          contentTextStyle:
          TextStyle(fontSize: 17.0, color: Colors.grey[800]),
          actions: [
            FlatButton(
              splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
              child: Text(
                "Cancel",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
              child: Text("Delete",
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () async {
                await Repository().deleteData('Pills', habitId);
                await Notifications().removeNotify(notifyId, flutterLocalNotificationsPlugin);
                setData();
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }

}
