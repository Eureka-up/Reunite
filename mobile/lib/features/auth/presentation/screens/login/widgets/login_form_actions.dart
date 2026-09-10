import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../login_form_controller.dart';
import 'login_glow_button.dart';
import 'login_modern_checkbox.dart';

class LoginFormActions extends StatelessWidget {
  const LoginFormActions({
    super.key,
    required this.controller,
    required this.loading,
    required this.onSubmit,
  });

  final LoginFormController controller;
  final bool loading;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            LoginModernCheckbox(
              value: controller.rememberMe,
              label: context.tr('auth.rememberMe'),
              onChanged: controller.setRememberMe,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => controller.goForgot(context),
              child: Text(
                context.tr('auth.forgotPassword'),
                style: context.textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 650.ms, duration: 400.ms),
        const SizedBox(height: 24),
        LoginGlowButton(
          label: context.tr('auth.login'),
          loading: loading,
          onPressed: loading ? null : () => onSubmit(),
        ).animate().fadeIn(delay: 700.ms, duration: 400.ms).slideY(
              begin: 0.06,
              end: 0,
            ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.tr('auth.noAccount'),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.palette.textMuted,
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => controller.goRegister(context),
              child: Text(
                context.tr('auth.register'),
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
      ],
    );
  }
}
