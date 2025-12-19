import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triptide/features/settings/screens/widgets/edit_profile_bottom_sheet.dart';
import 'package:triptide/features/settings/screens/widgets/language_tile.dart';
import 'package:triptide/features/settings/screens/widgets/settings_header.dart';
import 'package:triptide/features/settings/screens/widgets/settings_section.dart';
import 'package:triptide/features/settings/screens/widgets/settings_tile.dart';
import 'package:triptide/features/settings/screens/widgets/theme_mode_tile.dart';

import '../../auth/provider/auth_providers.dart';
import '../provider/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userInfoProvider);
    final currentLanguage = ref.watch(languageNotifierProvider);
    final themeMode = ref.watch(themeModeNotifierProvider);

    if (user == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFF8F9FD),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 8),
                SettingsHeader(
                  name: user.name ?? 'User',
                  email: user.email,
                  photoUrl: user.profilePic,
                  onEditPressed: () => _showEditProfileSheet(context, ref),
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: 'Preferences',
                  children: [
                    ThemeModeTile(
                      initialValue: themeMode == ThemeMode.dark,
                      onChanged: (isDark) {
                        ref
                            .read(themeModeNotifierProvider.notifier)
                            .toggleTheme();
                      },
                    ),
                    const SizedBox(height: 12),
                    LanguageSelectorTile(
                      currentLanguage: currentLanguage,
                      onLanguageSelected: (language) {
                        ref
                            .read(languageNotifierProvider.notifier)
                            .changeLanguage(language);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: 'Account',
                  children: [
                    SettingsTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'Privacy & Security',
                      subtitle: 'Manage your privacy settings',
                      onTap: () {
                        // Navigate to privacy settings
                      },
                    ),
                    const SizedBox(height: 12),
                    SettingsTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'Configure notification preferences',
                      onTap: () {
                        // Navigate to notification settings
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: 'Support',
                  children: [
                    SettingsTile(
                      icon: Icons.help_outline_rounded,
                      title: 'Help & Support',
                      subtitle: 'Get help with the app',
                      onTap: () {
                        // Navigate to help
                      },
                    ),
                    const SizedBox(height: 12),
                    SettingsTile(
                      icon: Icons.info_outline_rounded,
                      title: 'About',
                      subtitle: 'App version and information',
                      onTap: () {
                        // Show about dialog
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: 'Actions',
                  children: [
                    SettingsTile(
                      icon: Icons.logout_rounded,
                      title: 'Log Out',
                      subtitle: 'Sign out of your account',
                      iconColor: const Color(0xFFEF4444),
                      titleColor: const Color(0xFFEF4444),
                      onTap: () => _showLogoutDialog(context, ref),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: const Color(0xFFF8F9FD),
      elevation: 0,
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF8F9FD), Color(0xFFEEF2FF)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.settings_rounded,
                      color: Color(0xFF6366F1),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context, WidgetRef ref) {
    final user = ref.read(userInfoProvider);
    if (user == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => EditProfileBottomSheet(
            currentName: user.name!,
            currentEmail: user.email,
            onSave: (name, email) {
              ref
                  .read(authStateNotifierProvider.notifier)
                  .updateUserData(name, email);
            },
          ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFEF4444),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Are you sure you want to log out of your account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFFF1F5F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Use existing auth provider's signOut method
                          ref
                              .read(authStateNotifierProvider.notifier)
                              .signOut();
                          Navigator.pop(context);
                          // Navigation is handled in your auth provider
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFFEF4444),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
