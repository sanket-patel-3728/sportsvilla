import 'package:book1/Screens/cricket_booking.dart';
import 'package:book1/Screens/football_booking.dart';
import 'package:book1/Screens/volleyball_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var firstContainer = MediaQuery.of(context).size.height / 3;
    var secondContainer = MediaQuery.of(context).size.height -
        firstContainer -
        kBottomNavigationBarHeight;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 50, right: 40, bottom: 50, left: 30),
                height: firstContainer,
                color: Color(0XFF990011),
                child: Center(
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                    // scale: 1.4,
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color(0XFF990011),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Turf Booking",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Color(0xFFc78616),
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: secondContainer,
            width: MediaQuery.of(context).size.width,
            // color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ListView(
                children: [
                  customContainer(
                    gameName: "Cricket",
                    img: "assets/cricket.png",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CricketBookingScreen(),
                          ));
                    },
                  ),
                  customContainer(
                    gameName: "Football",
                    img: "assets/football.png",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FootballBookingScreen(),
                          ));
                    },
                  ),
                  customContainer(
                    gameName: "Volleyball",
                    img: "assets/volleyball.png",
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VolleyBookingScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget customContainer({String gameName, String img, Function onTap}) {
  return Container(
    height: 130,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(img),
              scale: 6.5,
            ),
            border: Border.all(
              color: Color(0xFFc78616),
              width: 3,
            ),
            // color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: onTap,
          color: Color(0XFF990011),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              gameName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
