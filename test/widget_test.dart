// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:triptide/features/auth/repository/firebase_repository.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late FakeFirebaseFirestore mockFirestore;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthRepository authRepository;

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});

  setUp(() async {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirestore = FakeFirebaseFirestore();
    mockGoogleSignIn = MockGoogleSignIn();
    mockFirebaseAuth = MockFirebaseAuth(
        mockUser: MockUser(
            uid: 'test_uid',
            email: 'test@gmail.com'
        )
    );
    authRepository = AuthRepository(
        firestore: mockFirestore,
        auth: mockFirebaseAuth,
        googleSignIn: mockGoogleSignIn,
    );
  },);
}
