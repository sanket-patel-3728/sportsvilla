import 'package:book1/Modal/user_modal.dart';
import 'package:book1/Screens/my_bookings.dart';
import 'package:book1/helper/auth_helper.dart';
import 'package:book1/helper/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String userName;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isLoading = false;

  void initState() {
    getDetails();
    isLoading = true;
    super.initState();
  }

  getDetails() async {
    User currentUser = await AuthHelper.getCurrentUser();
    UserModal.email = currentUser.email;
    UserModal.userId = currentUser.uid;

    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.getUserByEmail(currentUser.email).then((value) {
      UserModal.username = value.docs[0]['name'];
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: SpinKitWave(
                color: Color(0XFF990011),
                size: 50.0,
              ),
            )
          : ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  decoration: BoxDecoration(
                    color: Color(0XFF990011),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        backgroundImage: (AssetImage("assets/user.png")),
                      ),
                      SizedBox(height: 14.0),
                      Text(
                        UserModal.username == null ? "" : UserModal.username,
                        style: TextStyle(
                          color: Color(0XFFFCF6F5FF),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        UserModal.email == null ? "" : UserModal.email,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0XFFFCF6F5FF),
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                customContainer(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MyBookings()));
                  },
                  img: "assets/ticket.png",
                  gameName: "My Bookings",
                ),
              ],
            ),
    );
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
}
