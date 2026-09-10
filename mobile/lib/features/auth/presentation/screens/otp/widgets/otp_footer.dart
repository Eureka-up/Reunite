import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';

class OtpFooter extends StatelessWidget {
  const OtpFooter({
    super.key,
    required this.loading,
    required this.codeValid,
    required this.seconds,
    required this.onVerify,
    required this.onResend,
  });

  final bool loading;
  final bool codeValid;
  final int seconds;
  final VoidCallback? onVerify;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppDimens.xl),
        AppButton(
          label: context.tr('auth.verify'),
          gradient: AppColors.brandGradient,
          loading: loading,
          onPressed: loading || !codeValid ? null : onVerify,
        ),
        const SizedBox(height: AppDimens.lg),
        Center(
          child: seconds > 0
              ? Text(
                  '${context.tr('auth.resendIn')} '
                  '00:${seconds.toString().padLeft(2, '0')}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.palette.textSecondary,
                  ),
                )
              : TextButton(
                  onPressed: onResend,
                  child: Text(context.tr('auth.resend')),
                ),
        ),
      ],
    );
  }
}
