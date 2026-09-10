import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.onRetry});
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.xl),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(color: context.palette.border),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(color: AppColors.emergencySoft, shape: BoxShape.circle),
            child: const Icon(Icons.wifi_off_rounded, color: AppColors.emergency),
          ),
          const SizedBox(height: 14),
          Text(context.tr('errors.title'), style: context.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            context.tr('errors.network'),
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary),
          ),
          const SizedBox(height: 16),
          AppButton(label: context.tr('common.retry'), icon: Icons.refresh_rounded, onPressed: onRetry),
        ],
      ),
    );
  }
}
