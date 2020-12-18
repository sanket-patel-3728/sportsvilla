import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String GroundBookDate;
  String GroundTime;
  String bookingAmount;
  String convenienceCharge;
  String ground;
  Timestamp timestamp;
  String totalAmount;

  Booking({
    this.GroundBookDate,
    this.GroundTime,
    this.bookingAmount,
    this.convenienceCharge,
    this.ground,
    this.timestamp,
    this.totalAmount,
  });

  factory Booking.fromDocument(DocumentSnapshot doc) {
    return Booking(
      GroundBookDate: doc['GroundBookDate'],
      GroundTime: doc['GroundTime'],
      bookingAmount: doc['bookingAmount'],
      convenienceCharge: doc['convenienceCharge'].toString(),
      ground: doc['ground'],
      timestamp: doc['timestamp'],
      totalAmount: doc['totalAmount'],
    );
  }
}
