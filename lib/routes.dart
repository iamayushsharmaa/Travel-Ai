import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/data/firebase_auth/provider/auth_providers.dart';
import 'package:triptide/screens/auth/onboarding_page.dart';
import 'package:triptide/screens/auth/signin_page.dart';
import 'package:triptide/screens/auth/signup_page.dart';
import 'package:triptide/screens/home/widget_tree.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStateChangeNotifier = ref.watch(authStateChangeNotifierProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/onBoarding',
    routes: [
      GoRoute(
        path: '/onBoarding',
        pageBuilder:
            (context, state) => const MaterialPage(child: OnBoardingPage()),
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (context, state) {
          return MaterialPage(child: SigninPage());
        },
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => MaterialPage(child: SignUpPage()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(child: WidgetTree()),
      ),
    ],
    redirect: (context, state) {
      final user = ref.read(userInfoProvider);
      final currentPath = state.uri.path;
      final isPublicRoute = [
        '/onBoarding',
        '/signin',
        '/signup',
      ].contains(currentPath);

      if (user != null && currentPath == '/onBoarding') {
        return '/home';
      } else if (user == null && !isPublicRoute) {
        return '/onBoarding';
      }
      return null;
    },
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
    refreshListenable: authStateChangeNotifier,
  );
});
