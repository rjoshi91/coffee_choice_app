import 'package:coffeechoiceapp/model/user.dart';
import 'package:coffeechoiceapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
//      .map((FirebaseUser user) => _userFromFirebaseUser(user));
//       or
        .map(_userFromFirebaseUser);
  }

  // sign-in anonymously
  Future signInAnony() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

// register with email & password
  Future registerWithEmailAndPassword(String email, String password, String name, String code, String mobile, String seatNumber) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser userRegistered = result.user;
      await DatabaseService(uid: userRegistered.uid).updateUserData(name, code, mobile, seatNumber);
      return _userFromFirebaseUser(userRegistered);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

// sign-in with email & password
  Future signInEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser userM = result.user;
      return _userFromFirebaseUser(userM);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
// sign out
  Future accountSignOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}