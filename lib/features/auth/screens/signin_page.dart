import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/loader.dart';

import '../../../core/extensions/context_l10n.dart';
import '../provider/auth_providers.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child:
                authState.isLoading
                    ? const Loader()
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.sign_in_title,
                          style: theme.textTheme.displaySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.sign_in_subtitle,
                          style: theme.textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 24),

                        /// Email
                        Text(
                          l10n.email_label,
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: l10n.email_hint,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.email_required;
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return l10n.email_invalid;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        /// Password
                        Text(
                          l10n.password_label,
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: l10n.password_hint,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return l10n.password_invalid;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        /// Sign in button
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await ref
                                    .read(authStateNotifierProvider.notifier)
                                    .signIn(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    );
                              }
                            },
                            child: Text(l10n.sign_in_button),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () => context.go('/signup'),
                            child: Text(l10n.no_account_signup),
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
