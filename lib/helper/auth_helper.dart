import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> getCurrentUser() async {
    final User user = await _auth.currentUser;
    return user;
  }

  Future signInWithEmail({String email, String password}) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final User user = res.user;
    return user;
  }

  Future signUpWithEmail({String email, String password}) async {
    final res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = res.user;
    return user;
  }

  Future resetPassword(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  static logOut() {
    return _auth.signOut();
  }
}
