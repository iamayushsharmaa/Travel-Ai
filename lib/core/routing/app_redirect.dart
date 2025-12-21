import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/provider/auth_providers.dart';
import 'app_routes.dart';

class AppRedirect {
  static String? handle(Ref ref, GoRouterState state) {
    final user = ref.read(userInfoProvider);
    final firebaseUser = ref.read(firebaseAuthProvider).currentUser;
    final currentPath = state.uri.path;

    final isPublicRoute = {
      AppRoutes.onboarding,
      AppRoutes.signIn,
      AppRoutes.signUp,
    }.contains(currentPath);

    if (firebaseUser != null && user == null) {
      return null;
    }

    if (user != null && isPublicRoute) {
      return AppRoutes.home;
    }

    if (user == null && !isPublicRoute) {
      return AppRoutes.onboarding;
    }

    return null;
  }
}
