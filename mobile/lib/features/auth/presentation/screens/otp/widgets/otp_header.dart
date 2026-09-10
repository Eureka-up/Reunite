import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          child: const Icon(
            Icons.shield_outlined,
            color: Colors.white,
            size: 34,
          ),
        ),
        const SizedBox(height: AppDimens.xl),
        Text(
          context.tr('auth.otpTitle'),
          style: context.textTheme.headlineMedium,
        ),
        const SizedBox(height: 4),
        Text(
          context.tr('auth.otpSubtitle'),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.palette.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimens.xxl),
      ],
    );
  }
}
