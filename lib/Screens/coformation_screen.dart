import 'package:book1/Modal/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final bookingRef = FirebaseFirestore.instance.collection("booking");
final cricketBooking = FirebaseFirestore.instance.collection("CricketBooking");
final DateTime timestamp = DateTime.now();

class ConformationScreen extends StatefulWidget {
  final String bookedTime;
  final double bookingAmount;
  final DateTime bookedDate;
  final String whichGround;
  final List timeBackendList;

  ConformationScreen({
    @required this.bookingAmount,
    @required this.bookedTime,
    @required this.bookedDate,
    @required this.whichGround,
    @required this.timeBackendList,
  });

  @override
  _ConformationScreenState createState() => _ConformationScreenState();
}

class _ConformationScreenState extends State<ConformationScreen> {
  static double cCharge;
  String BookingDate;
  double BookingAmount;
  double total;
  String BookingTime;
  String WhichGround;
  String d = "";

  @override
  void initState() {
    BookingAmount = widget.bookingAmount;
    BookingTime = widget.bookedTime;
    BookingDate =
        "${widget.bookedDate.day}${widget.bookedDate.month}${widget.bookedDate.year}";
    WhichGround = widget.whichGround;
    cCharge = BookingAmount * 0.02;
    total = BookingAmount + cCharge;
    super.initState();
    widget.timeBackendList.forEach((v) {
      d = d + v.toString() + ",";
    });
    print(d);
  }

  createBookingInDatabase() {
    bookingRef.doc(UserModal.userId).collection("userBooking").doc().set({
      "ground": "$WhichGround",
      "GroundBookDate":
          "${widget.bookedDate.day} / ${widget.bookedDate.month} / ${widget.bookedDate.year}",
      "GroundTime": "$BookingTime",
      "bookingAmount": "$BookingAmount",
      "convenienceCharge": cCharge,
      "totalAmount": "$total",
      "timestamp": timestamp,
    });

    cricketBooking.doc(BookingDate).set({
      "index": d,
      "id": DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Card(
                      shadowColor: Colors.black,
                      elevation: 10,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0XFFFCF6F5FF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User Details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Card(
                              elevation: 3,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    // ),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Color(0XFF990011),
                                    ),
                                    SizedBox(width: 13),
                                    Text(
                                      UserModal.username,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Card(
                              elevation: 3,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    // ),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Color(0XFF990011),
                                    ),
                                    SizedBox(width: 13),
                                    Flexible(
                                      child: Text(
                                        UserModal.email,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      shadowColor: Colors.black,
                      elevation: 10,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0XFFFCF6F5FF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Booking Information",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0XFF990011),
                                ),
                                SizedBox(width: 13),
                                Text(
                                  "Sports Villas Arena",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.group_work,
                                  color: Color(0XFF990011),
                                ),
                                SizedBox(width: 13),
                                Text(
                                  "$WhichGround Ground",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Color(0XFF990011),
                                ),
                                SizedBox(width: 13),
                                Text(
                                  "${widget.bookedDate.day} / ${widget.bookedDate.month} / ${widget.bookedDate.year}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Color(0XFF990011),
                                ),
                                SizedBox(width: 13),
                                Flexible(
                                  child: Text(
                                    BookingTime,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      shadowColor: Colors.black,
                      elevation: 10,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0XFFFCF6F5FF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Information",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booking Amount ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹ $BookingAmount",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Convenience Charge",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹ $cCharge",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              color: Color(0XFFFCF6F5FF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Billing Amount :\n ₹ $total",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF990011)),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    onPressed: () {
                      createBookingInDatabase();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 12,
                      ),
                      child: Text(
                        "PAY NOW",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0XFF990011),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
