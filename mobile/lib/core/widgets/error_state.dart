import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';
import 'app_button.dart';

/// Professional error state with retry.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: context.palette.emergencySoft,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cloud_off_rounded,
                  size: 46, color: context.colorScheme.error),
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .scale(begin: const Offset(0.6, 0.6), duration: 400.ms),
            const SizedBox(height: AppDimens.lg),
            Text(
              context.tr('errors.title'),
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: AppDimens.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.palette.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.xl),
            AppButton(
              label: context.tr('common.retry'),
              onPressed: onRetry,
              icon: Icons.refresh_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
