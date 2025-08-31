import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class AuthService extends ChangeNotifier {
final _auth = FirebaseAuth.instance;


User? get currentUser => _auth.currentUser;


Stream<User?> authChanges() => _auth.authStateChanges();


Future<void> signOut() async => _auth.signOut();


Future<UserCredential> signInWithEmail(String email, String password) async {
return await _auth.signInWithEmailAndPassword(email: email, password: password);
}


Future<UserCredential> registerWithEmail(String email, String password) async {
return await _auth.createUserWithEmailAndPassword(email: email, password: password);
}
}
