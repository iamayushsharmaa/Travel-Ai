import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triptide/core/extensions/context_l10n.dart';
import 'package:triptide/features/settings/screens/widgets/edit_profile_bottom_sheet.dart';
import 'package:triptide/features/settings/screens/widgets/language_tile.dart';
import 'package:triptide/features/settings/screens/widgets/settings_header.dart';
import 'package:triptide/features/settings/screens/widgets/settings_section.dart';
import 'package:triptide/features/settings/screens/widgets/settings_tile.dart';
import 'package:triptide/features/settings/screens/widgets/theme_mode_tile.dart';

import '../../../core/common/app_dialog.dart';
import '../../../core/common/async_view.dart';
import '../../auth/provider/auth_providers.dart';
import '../provider/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userInfoProvider);
    final localeAsync = ref.watch(languageNotifierProvider);
    final themeAsync = ref.watch(themeModeNotifierProvider);

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
          _buildSliverAppBar(context),
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
                  title: context.l10n.preferences,
                  children: [
                    AsyncView<ThemeMode>(
                      value: themeAsync,
                      builder: (themeMode) {
                        final isDark = themeMode == ThemeMode.dark;

                        return ThemeModeTile(
                          isDarkMode: isDark,
                          onToggle: () {
                            ref
                                .read(themeModeNotifierProvider.notifier)
                                .toggleTheme();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    AsyncView<Locale>(
                      value: localeAsync,
                      builder: (locale) {
                        return LanguageSelectorTile(
                          currentLocale: locale,
                          onLanguageSelected: (newLocale) {
                            ref
                                .read(languageNotifierProvider.notifier)
                                .changeLanguage(newLocale);
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: context.l10n.account,
                  children: [
                    SettingsTile(
                      icon: Icons.lock_outline_rounded,
                      title: context.l10n.privacySecurity,
                      subtitle: context.l10n.privacySecurityDescription,
                      onTap: () {
                        // Navigate to privacy settings
                      },
                    ),
                    const SizedBox(height: 12),
                    SettingsTile(
                      icon: Icons.notifications_outlined,
                      title: context.l10n.notifications,
                      subtitle: context.l10n.notificationsDescription,
                      onTap: () {
                        // Navigate to notification settings
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: context.l10n.support,
                  children: [
                    SettingsTile(
                      icon: Icons.help_outline_rounded,
                      title: context.l10n.helpSupport,
                      subtitle: context.l10n.helpSupportDescription,
                      onTap: () {
                        // Navigate to help
                      },
                    ),
                    const SizedBox(height: 12),
                    SettingsTile(
                      icon: Icons.info_outline_rounded,
                      title: context.l10n.about,
                      subtitle: context.l10n.aboutDescription,
                      onTap: () {
                        // Show about dialog
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: context.l10n.actions,
                  children: [
                    SettingsTile(
                      icon: Icons.logout_rounded,
                      title: context.l10n.logOut,
                      subtitle: context.l10n.logOutDescription,
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

  Widget _buildSliverAppBar(BuildContext context) {
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
                  Text(
                    context.l10n.settings,
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

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialog.destructive(
      context,
      icon: Icons.logout_rounded,
      title: context.l10n.logOut,
      message: context.l10n.logOutConfirmation,
      confirmText: context.l10n.logOut,
      cancelText: context.l10n.cancel,
    );

    if (confirmed == true) {
      ref.read(authStateNotifierProvider.notifier).signOut();
    }
  }
}
