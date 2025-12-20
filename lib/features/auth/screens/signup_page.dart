import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/loader.dart';

import '../../../core/extensions/context_l10n.dart';
import '../provider/auth_providers.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  void signUpClicked() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authStateNotifierProvider.notifier)
          .signUp(emailController.text.trim(), passwordController.text.trim());
    }
  }

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
                          l10n.sign_up_title,
                          style: theme.textTheme.displaySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.sign_up_subtitle,
                          style: theme.textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 24),

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

                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: signUpClicked,
                            child: Text(l10n.sign_up_button),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () => context.go('/signin'),
                            child: Text(l10n.already_have_account),
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
