import 'package:firebase_auth/firebase_auth.dart';
import 'package:guru4cars/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on Firebase user

  UserData? _userFromFirebaseUser(User? user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  // auth change user steam
  Stream<UserData?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anony

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  //sign in email

  //register email

  //sign out

}
