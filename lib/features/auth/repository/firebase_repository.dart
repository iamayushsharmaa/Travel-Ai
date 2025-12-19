import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:triptide/core/failure.dart';
import 'package:triptide/core/type_def.dart';

import '../../../core/constant/firebase_constant.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  }) : _firestore = firestore,
       _auth = auth,
       _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstant.userCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();
  FutureEither<UserModel> signInWithGoogle() async {
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        googleAuthProvider.addScope('https://www.googleapis.com/screens/contacts.readonly');
        userCredential = await _auth.signInWithPopup(googleAuthProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        userCredential = await _auth.signInWithCredential(credential);
      }

      final uid = userCredential.user!.uid;
      final userDoc = await _users.doc(uid).get();

      late UserModel userModel;

      if (!userDoc.exists || userDoc.data() == null) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'No Name',
          email: userCredential.user!.email!,
          profilePic: userCredential.user!.photoURL ?? '',
          uid: uid,
          isAuthenticated: true,
        );
        await _users.doc(uid).set(userModel.toMap());
      } else {
        userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      }

      print("User repo: $userModel");
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }


  FutureEither<UserModel?> signin(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = await getUserData(userCredential.user!.uid).first;
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel?> signup(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: userCredential.user!.displayName ?? 'Name',
        profilePic: userCredential.user!.photoURL ?? '',
        isAuthenticated: true,
      );
      await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> updateUserData(UserModel user) async {
    await _users.doc(user.uid).update(user.toMap());
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) {
      return UserModel.fromMap(event.data() as Map<String, dynamic>);
    });
  }

  Future<void> signout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
