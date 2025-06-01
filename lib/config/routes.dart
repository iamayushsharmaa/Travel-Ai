import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/features/addtrip/screens/add_trip.dart';
import 'package:triptide/features/history/screen/trip_history.dart';
import 'package:triptide/features/search/screens/search_screen.dart';

import '../features/auth/provider/auth_providers.dart';
import '../features/auth/screens/onboarding_page.dart';
import '../features/auth/screens/signin_page.dart';
import '../features/auth/screens/signup_page.dart';
import '../features/home/screens/home_page.dart';
import '../features/home/screens/trip_page.dart';
import '../features/nav/widget_tree.dart';
import '../features/profile/screen/profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = ValueNotifier<bool>(false);

  ref.listen(userInfoProvider, (previous, next) {
    listenable.value = !listenable.value;
  });

  final initialLocation =
      ref.read(firebaseAuthProvider).currentUser != null
          ? '/home'
          : '/onBoarding';

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    refreshListenable: listenable,
    routes: [
      GoRoute(
        path: '/onBoarding',
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        path: '/signin',
        name: 'signin',
        builder: (context, state) => SigninPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => SignUpPage(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return WidgetTree(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/addtrip',
            name: 'addTrip',
            builder: (context, state) => AddTripPage(),
          ),
          GoRoute(
            path: '/history',
            name: 'history',
            builder: (context, state) => TripHistory(),
          ),
        ],
      ),

      GoRoute(
        path: '/trip/:travelId',
        name: 'trip',
        builder: (context, state) {
          final travelId = state.pathParameters['travelId']!;
          return TripPage(travelId: travelId);
        },
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => SearchScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => ProfileScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
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
        return '/home';
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
