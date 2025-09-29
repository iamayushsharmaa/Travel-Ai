import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:triptide/features/auth/models/user_model.dart';
import 'package:triptide/features/auth/repository/firebase_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthRepository repository;
  late MockCollectionReference mockUsersCollection;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockGoogleSignIn = MockGoogleSignIn();
    repository = AuthRepository(
      auth: mockAuth,
      firestore: mockFirestore,
      googleSignIn: mockGoogleSignIn,
    );

    mockUsersCollection = MockCollectionReference();
  });

  group('AuthRepository Tests', () {
    test('getUserData returns user from Firestore snapshot', () async {
      final uid = '123';
      final mockDocRef = MockDocumentReference();
      final mockSnapshot = MockDocumentSnapshot();

      when(mockUsersCollection.doc(uid)).thenReturn(mockDocRef);
      when(
        mockDocRef.snapshots(),
      ).thenAnswer((_) => Stream.value(mockSnapshot));
      when(mockSnapshot.data()).thenReturn({
        'uid': uid,
        'name': 'Test User',
        'email': 'test@example.com',
        'profilePic': '',
        'isAuthenticated': true,
        'password': null,
      });

      final userStream = repository.getUserData(uid);

      final user = await userStream.first;
      expect(user, isA<UserModel>());
      expect(user.uid, uid);
      expect(user.name, 'Test User');
    });
  });
}
