

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:triptide/data/firebase_auth/repository/firebase_repository.dart';

final GetIt locator = GetIt.instance;

void setUpLocator(){

  locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  locator.registerLazySingleton<AuthRepository>(
        () => AuthRepository(firebaseAuth: locator<FirebaseAuth>()),
  );
}