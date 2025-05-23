import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/data/firebase_auth/models/user_model.dart';

import '../repository/firebase_repository.dart';

part 'auth_providers.g.dart';

@riverpod
class UserInfo extends _$UserInfo {
  @override
  UserModel? build() => null; // Initial state is null

  void updateUser(UserModel? userModel) {
    state = userModel;
  }
}

@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

@riverpod
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
GoogleSignIn googleSignIn(GoogleSignInRef ref) {
  return GoogleSignIn();
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  );
}

@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AsyncValue<UserModel?> build() => const AsyncValue.data(null);

  Stream<User?> get authStateChange =>
      ref.watch(authRepositoryProvider).authStateChange;

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.read(authRepositoryProvider).signInWithGoogle();

      result.fold(
        (failure) {
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (userModel) {
          ref.read(userInfoProvider.notifier).updateUser(userModel);
          print(userModel);
          state = AsyncValue.data(userModel);
        },
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .signin(email, password);

      result.fold(
        (failure) {
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (user) {
          ref.read(userInfoProvider.notifier).updateUser(user);
          state = AsyncValue.data(user);
        },
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .signup(email, password);

      result.fold(
        (failure) {
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (user) {
          ref.read(userInfoProvider.notifier).updateUser(user);
          state = AsyncValue.data(user);
        },
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return ref.read(authRepositoryProvider).getUserData(uid);
  }

  void signOut() async {
    ref.read(authRepositoryProvider).signout();
  }
}
