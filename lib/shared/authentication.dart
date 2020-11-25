import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    return user.uid;
  }

  Future signUp(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    return user.uid;
  }

  Future signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User> getUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }
}
