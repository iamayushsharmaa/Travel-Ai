import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/routing/route_builder.dart';

import '../../features/auth/provider/auth_providers.dart';
import 'app_redirect.dart';
import 'app_routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ValueNotifier<bool>(false);

  ref.listen(userInfoProvider, (_, __) {
    refreshNotifier.value = !refreshNotifier.value;
  });

  final initialLocation =
      ref.read(firebaseAuthProvider).currentUser != null
          ? AppRoutes.home
          : AppRoutes.onboarding;

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    refreshListenable: refreshNotifier,
    routes: RouteBuilders.buildRoutes(),
    redirect: (context, state) => AppRedirect.handle(ref, state),
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(child: Text('Page not found: ${state.uri}')),
      );
    },
  );
});
