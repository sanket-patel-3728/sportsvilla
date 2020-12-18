import 'package:book1/Modal/booking_modal.dart';
import 'package:book1/Modal/user_modal.dart';
import 'package:book1/Screens/coformation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<Booking> bookings = [];
  bool isLoading = false;

  getUserBookings() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await bookingRef
        .doc(UserModal.userId)
        .collection('userBooking')
        .orderBy('timestamp', descending: true)
        .get();

    setState(() {
      isLoading = false;
      bookings = snapshot.docs.map((doc) => Booking.fromDocument(doc)).toList();
    });
    print(snapshot.docs.length);
  }

  buildBooking() {
    if (isLoading) {
      return Center(
        child: SpinKitWave(
          color: Colors.red,
          size: 50.0,
        ),
      );
    } else if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "No Bookings Available",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      List<GridTile> gridTiles = [];
      bookings.forEach((booking) {
        gridTiles.add(GridTile(child: BookingTile(booking)));
      });
      return GridView.count(
        childAspectRatio: 3 / 2.5,
        crossAxisCount: 1,
        physics: ScrollPhysics(),
        children: gridTiles,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUserBookings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0XFFFCF6F5FF),
          title: Text(
            "My Bookings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
              color: Colors.red,
            ),
          ),
        ),
        body: buildBooking(),
      ),
    );
  }
}

class BookingTile extends StatelessWidget {
  final Booking booking;

  BookingTile(this.booking);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: ClipRect(
          child: Banner(
            message: "Booked",
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            location: BannerLocation.topEnd,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0XFFFCF6F5FF),
              ),
              height: 160,
              child: ListView(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.group_work,
                              color: Color(0XFF990011),
                            ),
                            SizedBox(width: 13),
                            Text(
                              "${booking.ground} Ground",
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
                              "${booking.GroundBookDate}",
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
                                "${booking.GroundTime}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
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
                              "₹ ${booking.bookingAmount}",
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
                              "₹ ${booking.convenienceCharge}",
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
                              "Total Booking Amount ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹ ${booking.totalAmount}",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
