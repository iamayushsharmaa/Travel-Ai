import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_provider.g.dart';

class PasswordVisibilityState {
  final bool obscurePassword;
  final IconData iconPassword;

  PasswordVisibilityState({
    required this.obscurePassword,
    required this.iconPassword,
  });

  PasswordVisibilityState copyWith({
    bool? obscurePassword,
    IconData? iconPassword,
  }) {
    return PasswordVisibilityState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      iconPassword: iconPassword ?? this.iconPassword,
    );
  }
}

@riverpod
class PasswordVisibility extends _$PasswordVisibility {

  @override
  PasswordVisibilityState build() {
    return PasswordVisibilityState(
        obscurePassword: true,
        iconPassword: CupertinoIcons.eye_fill
    );
  }

  void togglePasswordVisibility() {
    final newObscure = !state.obscurePassword;
    state = state.copyWith(
      obscurePassword: newObscure,
      iconPassword: newObscure
          ? CupertinoIcons.eye_fill
          : CupertinoIcons.eye_slash_fill,
    );
  }
}