import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:jouleslab/repository.dart';
import 'package:jouleslab/snack_bar.dart';
import 'package:jouleslab/habit.dart';
import 'package:jouleslab/notifications.dart';
import 'package:jouleslab/platform_flat_button.dart';
import 'package:jouleslab/form_fields.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AddNewHabit extends StatefulWidget {
  @override
  _AddNewHabitState createState() => _AddNewHabitState();
}

class _AddNewHabitState extends State<AddNewHabit> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();

  int howManyWeeks = 1;
  String selectWeight;
  DateTime setDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  //==========================================

  //-------------- Database and notifications ------------------
  final Repository _repository = Repository();
  final Notifications _notifications = Notifications();

  //============================================================

  @override
  void initState() {
    super.initState();
    initNotifies();
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin =
  await _notifications.initNotifies(context);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: deviceHeight * 0.05,
                child: FittedBox(
                  child: InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(left: 15.0),
                height: deviceHeight * 0.05,
                child: FittedBox(
                    child: Text(
                      "Add Habits",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.black),
                    )),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Container(
                height: deviceHeight * 0.37,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FormFields(
                        howManyWeeks,
                        selectWeight,
                        popUpMenuItemChanged,
                        sliderChanged,
                        nameController,
                        amountController)),
              ),
              SizedBox(
                height: deviceHeight * 0.04,
              ),
              Container(
                width: double.infinity,
                height: deviceHeight * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openTimePicker(),
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DateFormat.Hm().format(this.setDate),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.access_time,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openDatePicker(),
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DateFormat("dd.MM").format(this.setDate),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.event,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: deviceHeight * 0.09,
                width: double.infinity,
                child: PlatformFlatButton(
                  handler: () async => saveHabit(),
                  color: Theme.of(context).primaryColor,
                  buttonChild: Text(
                    "Set Remainder",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //slider changer
  void sliderChanged(double value) =>
      setState(() => this.howManyWeeks = value.round());

  //choose popum menu item
  void popUpMenuItemChanged(String value) =>
      setState(() => this.selectWeight = value);


  Future<void> openTimePicker() async {
    await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: "Choose Time")
        .then((value) {
      DateTime newDate = DateTime(
          setDate.year,
          setDate.month,
          setDate.day,
          value != null ? value.hour : setDate.hour,
          value != null ? value.minute : setDate.minute);
      setState(() => setDate = newDate);
      print(newDate.hour);
      print(newDate.minute);
    });
  }


  Future<void> openDatePicker() async {
    await showDatePicker(
        context: context,
        initialDate: setDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);
      setState(() => setDate = newDate);
      print(setDate.day);
      print(setDate.month);
      print(setDate.year);
    });
  }


  Future saveHabit() async {
    if (setDate.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch) {
      snackbar.showSnack(
          "Check your habit time and date", _scaffoldKey, null);
    } else {
      //create pill object
      Habit habit = Habit(
          description: amountController.text,
          howManyWeeks: howManyWeeks,
          name: nameController.text,
          time: setDate.millisecondsSinceEpoch,
          notifyId: Random().nextInt(10000000));

      //---------------------| Save as many medicines as many user checks |----------------------
      for (int i = 0; i < howManyWeeks; i++) {
        dynamic result =
        await _repository.insertData("Pills", habit.habitToMap());
        if (result == null) {
          snackbar.showSnack("Something went wrong", _scaffoldKey, null);
          return;
        } else {
          //set the notification schedule
          tz.initializeTimeZones();
          tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));
          await _notifications.showNotification(habit.name, habit.description, time,
              habit.notifyId,
              flutterLocalNotificationsPlugin);
          setDate = setDate.add(Duration(milliseconds: 604800000));
          habit.time = setDate.millisecondsSinceEpoch;
          habit.notifyId = Random().nextInt(10000000);
        }
      }
      snackbar.showSnack("Saved", _scaffoldKey, null);
      Navigator.pop(context);
    }
  }

  int get time =>
      setDate.millisecondsSinceEpoch -
          tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
}
