import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jouleslab/notifications.dart';
import 'package:jouleslab/repository.dart';
import 'package:jouleslab/habit.dart';
import 'package:jouleslab/habit_list.dart';
import 'package:jouleslab/calendar.dart';
import 'package:jouleslab/calendar_day_model.dart';
import 'package:jouleslab/add_new_habit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Notifications _notifications = Notifications();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  List<Habit> allListOfhabits = List<Habit>();
  final Repository _repository = Repository();
  List<Habit> dailyhabits = List<Habit>();

  final CalendarDayModel _days = CalendarDayModel();
  List<CalendarDayModel> _daysList;

  int _lastChooseDay = 0;

  @override
  void initState() {
    super.initState();
    initNotifies();
    setData();
    _daysList = _days.getCurrentDays();
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin = await _notifications.initNotifies(context);


  Future setData() async {
    allListOfhabits.clear();
    (await _repository.getAllData("Pills")).forEach((habitMap) {
      allListOfhabits.add(Habit().habitMapToObject(habitMap));
    });
    chooseDay(_daysList[_lastChooseDay]);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final Widget addButton = FloatingActionButton(
      elevation: 2.0,
      onPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewHabit()))
            .then((_) => setData());
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    return Scaffold(
      floatingActionButton: addButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, left: 25.0, right: 25.0, bottom: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pick a Day",
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(color: Colors.black),
                        ),
                        ShakeAnimatedWidget(
                          enabled: true,
                          duration: Duration(milliseconds: 2000),
                          curve: Curves.linear,
                          shakeAngle: Rotation.deg(z: 30),
                          child: Icon(
                            Icons.notifications_none,
                            size: 42.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Calendar(chooseDay,_daysList),
                ),
                SizedBox(height: deviceHeight * 0.03),
                dailyhabits.isEmpty
                    ? SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: WavyAnimatedTextKit(
                    textStyle: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text: [
                      "Loading..."
                    ],
                    isRepeatingAnimation: true,
                    speed: Duration(milliseconds: 150),
                  ),
                )
                    : HabitList(dailyhabits,setData,flutterLocalNotificationsPlugin)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDay(CalendarDayModel clickedDay){
    setState(() {
      _lastChooseDay = _daysList.indexOf(clickedDay);
      _daysList.forEach((day) => day.isChecked = false );
      CalendarDayModel chooseDay = _daysList[_daysList.indexOf(clickedDay)];
      chooseDay.isChecked = true;
      dailyhabits.clear();
      allListOfhabits.forEach((habit) {
        DateTime habitDate = DateTime.fromMicrosecondsSinceEpoch(habit.time * 1000);
        if(chooseDay.dayNumber == habitDate.day && chooseDay.month == habitDate.month && chooseDay.year == habitDate.year){
          dailyhabits.add(habit);
        }
      });
      dailyhabits.sort((habit1,habit2) => habit1.time.compareTo(habit2.time));
    });
  }
}
