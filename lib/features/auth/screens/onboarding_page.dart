import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/shared/widgets/signin_button.dart';

import '../provider/auth_providers.dart';


class OnBoardingPage extends ConsumerWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            authState.isLoading
                ? const Loader()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    const CenterText(),
                    const Spacer(flex: 2),
                    SignInButton(),
                    continueWithEmailButton(
                      onPressed: () => context.go('/signin'),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
      ),
    );
  }
}

class CenterText extends StatelessWidget {
  const CenterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Go plan with Travel AI.',
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class continueWithEmailButton extends StatelessWidget {
  final VoidCallback onPressed;

  const continueWithEmailButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email, color: Colors.white, size: 27),
              SizedBox(width: 8),
              const Text(
                'Continue with email',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
