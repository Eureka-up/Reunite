import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class PrefGroup extends StatelessWidget {
  const PrefGroup({super.key});
  @override
  Widget build(BuildContext context) {
    return ProfileGroupCard(children: [
      ProfileTile(icon: Icons.notifications_rounded, color: AppColors.primary, title: context.tr('profile.notificationSettings'), subtitle: 'Push, nearby, matches', onTap: () => context.router.push(const SettingsRoute())),
      const ProfileDivider(),
      ProfileTile(icon: Icons.language_rounded, color: AppColors.secondary, title: context.tr('profile.language'), subtitle: context.locale.languageCode == 'ar' ? 'العربية' : 'English', onTap: () => context.router.push(const SettingsRoute())),
      const ProfileDivider(),
      ProfileTile(icon: Icons.palette_rounded, color: AppColors.accent, title: context.tr('profile.theme'), subtitle: 'Light / Dark / System', onTap: () => context.router.push(const SettingsRoute())),
    ]);
  }
}

class SupportGroup extends StatelessWidget {
  const SupportGroup({super.key});
  @override
  Widget build(BuildContext context) {
    return ProfileGroupCard(children: [
      ProfileTile(icon: Icons.lock_rounded, color: const Color(0xFF6B7280), title: context.tr('profile.privacy'), subtitle: 'Policy & data', onTap: () => context.router.push(const SettingsRoute())),
      const ProfileDivider(),
      ProfileTile(icon: Icons.help_rounded, color: AppColors.info, title: context.tr('profile.help'), subtitle: 'FAQ & contact', onTap: () => context.router.push(const SettingsRoute())),
      const ProfileDivider(),
      ProfileTile(icon: Icons.info_rounded, color: const Color(0xFF6B7280), title: context.tr('profile.about'), subtitle: 'Version 1.0.0', onTap: () => context.router.push(const SettingsRoute())),
    ]);
  }
}

class ProfileGroupCard extends StatelessWidget {
  const ProfileGroupCard({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: context.palette.border), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 14, offset: const Offset(0, 6))]),
      child: Column(children: children),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.icon, required this.color, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Row(
            children: [
              Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withValues(alpha: 0.11), borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 20, color: color)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 13.5)), Text(subtitle, style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary, fontSize: 11.5))])),
              const SizedBox(width: 8),
              Container(width: 28, height: 28, decoration: BoxDecoration(color: context.palette.surfaceAlt, shape: BoxShape.circle), child: Icon(Icons.chevron_right_rounded, size: 16, color: context.palette.textMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key});
  @override
  Widget build(BuildContext context) => Divider(height: 1, thickness: 1, color: context.palette.border.withValues(alpha: 0.65), indent: 66);
}
