import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triptide/screens/auth/onboarding_page.dart';
import 'package:triptide/screens/home/widget_tree.dart';

import '../../data/firebase_auth/provider/auth_providers.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      loading:
          () => const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          ),
      data: (user) => user != null ? WidgetTree() : OnBoardingPage(),
      error:
          (error, _) => Scaffold(body: Center(child: Text("Error : $error"))),
    );
  }
}
