import 'package:book1/Screens/select_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class VolleyBookingScreen extends StatefulWidget {
  @override
  _VolleyBookingScreenState createState() => _VolleyBookingScreenState();
}

class _VolleyBookingScreenState extends State<VolleyBookingScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cricket Booking",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
                child: Text(
                  "Venue :",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  border: Border(
                    left: BorderSide(color: Colors.greenAccent, width: 7.0),
                    right: BorderSide(color: Colors.greenAccent, width: 7.0),
                  ),
                ),
                child: Center(
                  child: Text("Address will come here."),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 20, bottom: 10),
                child: Text(
                  "Select Date :",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _pickDate(context);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "${dateTime.day} / ${dateTime.month} / ${dateTime.year}",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 20, bottom: 10),
                child: Text(
                  "Select Time :",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TimeSelect(
                        dateTime: dateTime,
                        whichGround: "Volleyball",
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Time",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pickDate(BuildContext context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 25),
    );
    if (date != null) {
      setState(() {
        dateTime = date;
      });
    }
  }
}
