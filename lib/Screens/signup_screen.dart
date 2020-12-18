import 'package:book1/Screens/main_screen.dart';
import 'package:book1/helper/auth_helper.dart';
import 'package:book1/helper/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggle;

  SignUpScreen(this.toggle);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  AuthHelper authHelper = AuthHelper();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _usernameController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    double firstContainerHeight = MediaQuery.of(context).size.height / 1.25;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: isLoading
            ? Center(
                child: SpinKitWave(
                  color: Colors.red,
                  size: 50.0,
                ),
              )
            : signUp(),
      ),
    );
  }

  Widget signUp() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff990011),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 40.0),
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
                scale: 1.2,
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      color: Color(0xffFCF6F5),
                      shadowColor: Colors.blue,
                      elevation: 5.0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Color(0xff990011),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.length < 2) {
                                    return "Please Enter Valid Username";
                                  }
                                  return null;
                                },
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Your Name",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Card(
                      color: Color(0xffFCF6F5),
                      shadowColor: Colors.blue,
                      elevation: 5.0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Color(0xff990011),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)
                                      ? null
                                      : "Please Enter Valid Email id";
                                },
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Card(
                      color: Color(0xffFCF6F5),
                      shadowColor: Colors.blue,
                      elevation: 5.0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.vpn_key,
                              color: Color(0xff990011),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  return value.length < 6
                                      ? "Please Enter Password 6+ charactrs"
                                      : null;
                                },
                                controller: _passwordController,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
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
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.greenAccent),
                ),
                GestureDetector(
                  onTap: () {
                    widget.toggle();
                  },
                  child: Text(
                    " Login Now !",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 30.0, left: 30.0, top: 50.0),
              child: GestureDetector(
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await authHelper
                          .signUpWithEmail(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      )
                          .then(
                        (value) {
                          Map<String, dynamic> userMap = {
                            "name": _usernameController.text.trim(),
                            "email": _emailController.text.trim(),
                          };
                          databaseHelper.uploadUserInfo(userMap);
                          if (value != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainHomeScreen(),
                                ));
                          }
                        },
                      );
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            (e as FirebaseAuthException).message,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  }
                },
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
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color(0xFFc78616),
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
