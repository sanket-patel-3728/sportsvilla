import 'package:book1/Screens/coformation_screen.dart';
import 'package:flutter/material.dart';

class TimeSelect extends StatefulWidget {
  final DateTime dateTime;
  final String whichGround;

  TimeSelect({
    @required this.dateTime,
    @required this.whichGround,
  });

  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String BookingDate;

  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;
    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  List<bool> inputs = new List<bool>();

  String StringTimeFromDB;

  @override
  void initState() {
    BookingDate =
        "${widget.dateTime.day}${widget.dateTime.month}${widget.dateTime.year}";
    getTimeFromDb().then((value) {
      bookedId = StringTimeFromDB.split(",");
    });
    super.initState();
    for (int i = 0; i < 33; i++) {
      inputs.add(false);
    }
  }

  Future getTimeFromDb() async {
    await cricketBooking.doc(BookingDate).get().then((value) {
      StringTimeFromDB = value.data()["index"].toString();
    });
  }

  void ItemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  List<SelectedTime> classList = [];
  double finalBookedAmount;
  String BookingTime = "";
  String D = "";
  List backEndList = [];
  List bookedId = [];

  @override
  Widget build(BuildContext context) {
    final startTime = TimeOfDay(hour: 6, minute: 0);
    final endTime = TimeOfDay(hour: 20, minute: 0);
    final step = Duration(minutes: 30);
    final times = getTimes(startTime, endTime, step)
        .map((tod) => tod.format(context))
        .toList();

    var widgets = ListView.builder(
      itemCount: times.length - 1,
      itemBuilder: (context, i) {
        return CheckboxListTile(
          title: Text("${times[i]} To ${times[i + 1]} (₹ 500.0)"),
          value: inputs[i],
          onChanged: (bool val) {
            ItemChange(val, i);
            if (val == true) {
              classList.add(SelectedTime(
                  id: i, firstTime: times[i], lastTime: times[i + 1]));
              backEndList.add(i);
            }
            if (val == false && classList.isNotEmpty) {
              classList.removeWhere((element) => i == element.id);
              backEndList.remove(i);
            }
          },
          activeColor: Color(0XFF990011),
          checkColor: Color(0XFFFCF6F5FF),
        );
      },
    );

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            Container(
              height: 50,
              color: Color(0XFF990011),
              child: Center(
                child: Text(
                  "${widget.dateTime.day} / ${widget.dateTime.month} / ${widget.dateTime.year}",
                  style: TextStyle(
                    color: Color(0XFFFCF6F5FF),
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(child: widgets),
            SizedBox(height: 70.0),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0XFF990011),
          onPressed: () {
            finalBookedAmount = classList.length * 500.0;
            classList.sort((a, b) => a.id.compareTo(b.id));
            backEndList.sort((a, b) => a.compareTo(b));
            classList.forEach((item) {
              print(
                  "Booked ground time is : ${item.id}, ${item.firstTime} , ${item.lastTime}");
              D = D + item.firstTime + " To " + item.lastTime + ",\n";
            });
            BookingTime = D;
            D = "";
            // print(BookingTime);
            // print(StringTimeFromDB);
            // print(BookingDate);
            print(times);
            print("booked ID is : $bookedId  ${bookedId.length}");
            for (int i = 0; i < bookedId.length; i++) {
              print(i);
              times.remove(int.parse(bookedId[i]));
              // print(int.parse(bookedId[i]));
            }
            print(times);

            if (classList.isEmpty || backEndList.isEmpty) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(
                  "Please Select Time",
                  textAlign: TextAlign.center,
                ),
              ));
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConformationScreen(
                  bookedTime: BookingTime,
                  bookingAmount: finalBookedAmount,
                  bookedDate: widget.dateTime,
                  whichGround: widget.whichGround,
                  timeBackendList: backEndList,
                ),
              ),
            );
          },
          child: Text("DONE"),
        ),
      ),
    );
  }
}

class SelectedTime {
  int id;
  String firstTime;
  String lastTime;

  SelectedTime({this.firstTime, this.lastTime, this.id});
}
