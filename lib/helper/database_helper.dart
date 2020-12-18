import 'package:book1/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final userRef = FirebaseFirestore.instance.collection('users');

class DatabaseHelper {
  static String currentUserUID;

  uploadUserInfo(userMap) async {
    final User currentUser = await AuthHelper.getCurrentUser();
    currentUserUID = currentUser.uid;
    userRef.doc(currentUser.uid).set(userMap);
  }

  getUserByEmail(String userEmail) async {
    return await userRef.where('email', isEqualTo: userEmail).get();
  }
}
