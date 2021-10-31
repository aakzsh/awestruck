import 'package:awestruck/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:pedometer/pedometer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awestruck/home.dart';
import 'package:intl/intl.dart';

class WalkHome extends StatefulWidget {
  @override
  _WalkHomeState createState() => _WalkHomeState();
}

class _WalkHomeState extends State<WalkHome> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  DateTime _selectedDay;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime _focusedDay = DateTime.now();
  DateTime today = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int rSteps = 0;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    print("trynna update");
    setState(() {
      _steps = event.steps.toString();

      if (!isSameDay(DateTime.parse(prevDay), today)) {
        FirebaseFirestore.instance
            .collection("users")
            .doc('shroo')
            .get()
            .then((value) => {
                  setState(() {
                    rSteps = value.data()['steps_total'];
                  })
                })
            .then((value) {
          firestore.collection('users').doc('shroo').update({
            'totalStepsUntilYesterday': rSteps,
            'prevDay': formatter.format(DateTime.now())
          });
        });

        today = DateTime.now();
        _focusedDay = DateTime.now();
        // prevDay = DateTime.now();
      }
      //update total steps
      firestore
          .collection('users')
          .doc('shroo')
          .update({'steps_total': event.steps});
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);

    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void getStepsData() {}

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    print(dateTime.weekday);
    return dateTime.subtract(Duration(days: dateTime.weekday % 7));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    DateTime fd = findFirstDateOfTheWeek(dateTime);
    return fd.add(Duration(days: 6));
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // double cont_w = (w - 40) / 3 - 15;
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Palette().bluebg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Steps Tracker",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                      )
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 180.0,
                  lineWidth: 13.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: 0.9,
                  animateFromLastPercent: true,
                  center: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Total Steps",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          //_steps- totaluntilyesterday
                          _steps,
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Color(0xff03CAA4),
                  backgroundColor: Color(0xff222D48),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff151D31),
                          borderRadius: BorderRadius.circular(10)),
                      width: 0.4 * w,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Column(
                          children: [
                            Text(
                              "Goals",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "1000",
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff86EDFB)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff151D31),
                          borderRadius: BorderRadius.circular(10)),
                      width: 0.4 * w,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Column(
                          children: [
                            Text(
                              "Coins",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "700",
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff86EDFB)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: TableCalendar(
                    calendarFormat: _calendarFormat,
                    firstDay: findFirstDateOfTheWeek(today),
                    lastDay: findLastDateOfTheWeek(today),
                    focusedDay: DateTime.now(),
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, day, focusedDay) {
                        final text = day.day.toString();
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Palette().auroraGreen,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                text,
                                style: TextStyle(color: Palette().bluebg),
                              ),
                            ),
                          ),
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        final text = day.day.toString();
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff0A5E4E), width: 2),
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                text,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          print(selectedDay.weekday);
                          //todo:update goals and steps based on date
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
