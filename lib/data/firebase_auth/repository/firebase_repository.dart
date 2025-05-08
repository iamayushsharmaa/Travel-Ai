
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository{

  final FirebaseAuth firebaseAuth;
  AuthRepository({required this.firebaseAuth});

  Future<User?> signup(String email, String password) async{
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    return userCredential.user;
  }

  Future<User?> signin(String email, String password) async{
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return userCredential.user;
  }

  Future<void> signout() async{
    await firebaseAuth.signOut();
  }

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
}