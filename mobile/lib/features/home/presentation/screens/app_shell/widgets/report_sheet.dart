import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import 'report_action.dart';

class ReportSheet extends StatelessWidget {
  const ReportSheet({super.key, required this.onMissing, required this.onFound});
  final VoidCallback onMissing;
  final VoidCallback onFound;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(28)), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 32, offset: const Offset(0, -8))]),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: context.palette.border, borderRadius: BorderRadius.circular(100))),
              const SizedBox(height: 18),
              Row(children: [
                Container(width: 42, height: 42, decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 22)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('How can you help?', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)), Text('Choose a report type', style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary, fontSize: 12))]))
              ]),
              const SizedBox(height: 18),
              Row(children: [
                ReportAction(icon: Icons.person_search_rounded, label: context.tr('home.reportMissing'), sub: 'Missing child', grad: AppColors.emergencyGradient, onTap: onMissing),
                const SizedBox(width: 12),
                ReportAction(icon: Icons.child_friendly_rounded, label: context.tr('home.foundChild'), sub: 'Found child', grad: AppColors.successGradient, onTap: onFound),
              ]),
              const SizedBox(height: 12),
              Text('Verified • Encrypted • Safe', textAlign: TextAlign.center, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textMuted, fontSize: 11)),
            ],
          ),
        ),
      ),
    ).animate().slideY(begin: 0.12, duration: 360.ms, curve: Curves.easeOutCubic).fadeIn(duration: 280.ms);
  }
}
