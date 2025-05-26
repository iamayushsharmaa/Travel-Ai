import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/features/addtrip/screens/add_trip.dart';
import 'package:triptide/features/home/screens/home_page.dart';
import 'package:triptide/features/home/screens/trip_page.dart';

import 'features/auth/provider/auth_providers.dart';
import 'features/auth/screens/onboarding_page.dart';
import 'features/auth/screens/signin_page.dart';
import 'features/auth/screens/signup_page.dart';
import 'features/nav/widget_tree.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = ValueNotifier<bool>(false);

  ref.listen(userInfoProvider, (previous, next) {
    listenable.value = !listenable.value;
  });
  final initialLocation =
      ref.read(firebaseAuthProvider).currentUser != null ? '/' : '/onBoarding';

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    refreshListenable: listenable,
    routes: [
      GoRoute(
        path: '/onBoarding',
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(path: '/signin', builder: (context, state) => SigninPage()),
      GoRoute(path: '/signup', builder: (context, state) => SignUpPage()),
      GoRoute(path: '/', builder: (context, state) => WidgetTree()),
      GoRoute(path: '/home', builder: (context, state) => HomePage()),
      GoRoute(path: '/addtrip', builder: (context, state) => AddTripPage()),
      GoRoute(
        path: '/trip/:travelId',
        name: 'trip',
        builder: (context, state) {
          final travelId = state.pathParameters['travelId']!;
          return TripPage(travelId: travelId);
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final user = ref.read(userInfoProvider);
      final currentPath = state.uri.path;
      final isPublicRoute = [
        '/onBoarding',
        '/signin',
        '/signup',
      ].contains(currentPath);
      final firebaseUser = ref.read(firebaseAuthProvider).currentUser;
      if (firebaseUser != null && user == null) {
        return null;
      }
      if (user != null && isPublicRoute) {
        return '/';
      }
      if (user == null && !isPublicRoute) {
        return '/onBoarding';
      }
      return null;
    },
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
});
