import 'package:flutter/material.dart';

import '../../../../core/extensions/context_theme.dart';

class SettingsHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? photoUrl;
  final VoidCallback onEditPressed;

  const SettingsHeader({
    super.key,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.primary.withOpacity(0.85)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildAvatar(context),
          const SizedBox(width: 16),
          Expanded(child: _buildUserInfo(context)),
          _buildEditButton(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: colors.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child:
          photoUrl != null
              ? ClipOval(
                child: Image.network(
                  photoUrl!,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => _buildAvatarPlaceholder(context),
                ),
              )
              : _buildAvatarPlaceholder(context),
    );
  }

  Widget _buildAvatarPlaceholder(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary.withOpacity(0.2),
            colors.primary.withOpacity(0.35),
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: context.text.headlineMedium?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final text = context.text;
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: text.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: colors.onPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: text.bodySmall?.copyWith(
            color: colors.onPrimary.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onEditPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.onPrimary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors.onPrimary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(Icons.edit_rounded, color: colors.onPrimary, size: 20),
      ),
    );
  }
}
