import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/data/firebase_auth/repository/firebase_repository.dart';

part 'auth_providers.g.dart';

@riverpod
FirebaseAuth firebaseAuth(Ref ref){
  return FirebaseAuth.instance;
}

@riverpod
AuthRepository authRepository(Ref ref){
  return AuthRepository(firebaseAuth: ref.watch(firebaseAuthProvider));
}

@riverpod
Stream<User?> authState(Ref ref){
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
class AuthStateNotifier extends $AuthStateNotifier{

  @override
  AsyncValue<User?> build(){
    return const AsyncValue.data(null);
  }


}