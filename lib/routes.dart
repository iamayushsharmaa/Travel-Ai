import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/data/firebase_auth/provider/auth_providers.dart';
import 'package:triptide/screens/auth/onboarding_page.dart';
import 'package:triptide/screens/auth/signin_page.dart';
import 'package:triptide/screens/auth/signup_page.dart';
import 'package:triptide/screens/home/widget_tree.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = ValueNotifier<bool>(false);

  ref.listen(userInfoProvider, (previous, next) {
    listenable.value = !listenable.value;
  });

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/onBoarding',
    refreshListenable: listenable,
    routes: [
      GoRoute(
        path: '/onBoarding',
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(path: '/signin', builder: (context, state) => SigninPage()),
      GoRoute(path: '/signup', builder: (context, state) => SignUpPage()),
      GoRoute(path: '/', builder: (context, state) => const WidgetTree()),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final user = ref.read(userInfoProvider);
      final currentPath = state.uri.path;
      final isPublicRoute = [
        '/onBoarding',
        '/signin',
        '/signup',
      ].contains(currentPath);

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
