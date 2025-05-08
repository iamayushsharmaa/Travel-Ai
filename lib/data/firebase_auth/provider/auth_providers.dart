import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/firebase_repository.dart';

part 'auth_providers.g.dart';

@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(firebaseAuth: ref.watch(firebaseAuthProvider));
}

@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AsyncValue<User?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(authRepositoryProvider).signup(email, password);
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(authRepositoryProvider).signin(email, password);
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).signout();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}