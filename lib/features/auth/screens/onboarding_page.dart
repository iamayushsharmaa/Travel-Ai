import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/shared/widgets/signin_button.dart';

import '../../../core/extensions/context_l10n.dart';
import '../provider/auth_providers.dart';

class OnBoardingPage extends ConsumerWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                    const SignInButton(),
                    ContinueWithEmailButton(
                      onPressed: () => context.goNamed('signIn'),
                    ),
                    const SizedBox(height: 10),
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
    final theme = Theme.of(context);

    return Center(
      child: Text(
        context.l10n.onboarding_title,
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineMedium,
      ),
    );
  }
}

class ContinueWithEmailButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueWithEmailButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email, size: 24),
              const SizedBox(width: 8),
              Text(
                context.l10n.continue_with_email,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
