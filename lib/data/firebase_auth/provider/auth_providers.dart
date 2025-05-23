import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/data/firebase_auth/models/user_model.dart';

import '../repository/firebase_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
class UserInfo extends _$UserInfo {
  @override
  UserModel? build() {
    ref.listen(authStateNotifierProvider, (previous, next) {
      state = next.value;
    });
    return null; // Initial state is null (no user logged in)
  }

  void updateUser(UserModel? user) {
    state = user;
  }

  void clearUser() {
    state = null;
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
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AsyncValue<UserModel?> build() {
    final authStateChange = ref.watch(authRepositoryProvider).authStateChange;

    ref.listenSelf((previous, next) {
      authStateChange.listen((firebaseUser) async {
        if (firebaseUser == null) {
          state = const AsyncValue.data(null);
          ref.read(userInfoProvider.notifier).clearUser();
        } else {
          final userData =
              await ref
                  .read(authRepositoryProvider)
                  .getUserData(firebaseUser.uid)
                  .first;
          state = AsyncValue.data(userData);
          ref.read(userInfoProvider.notifier).updateUser(userData);
        }
      });
    });

    return const AsyncValue.data(null);
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.read(authRepositoryProvider).signInWithGoogle();

      result.fold(
        (failure) {
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (userModel) {
          state = AsyncValue.data(userModel);
          ref.read(userInfoProvider.notifier).updateUser(userModel);
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
          state = AsyncValue.data(user);
          ref.read(userInfoProvider.notifier).updateUser(user);
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
          state = AsyncValue.data(user);
          ref.read(userInfoProvider.notifier).updateUser(user);
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
