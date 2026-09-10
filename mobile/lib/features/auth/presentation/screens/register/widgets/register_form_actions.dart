import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../register_form_controller.dart';
import 'register_glow_button.dart';
import 'register_terms_tile.dart';

class RegisterFormActions extends StatelessWidget {
  const RegisterFormActions({
    super.key,
    required this.controller,
    required this.loading,
    required this.onSubmit,
  });

  final RegisterFormController controller;
  final bool loading;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RegisterTermsTile(
          value: controller.terms,
          onChanged: controller.setTerms,
        ).animate().fadeIn(delay: 740.ms, duration: 400.ms),
        const SizedBox(height: 24),
        RegisterGlowButton(
          label: context.tr('auth.createAccount'),
          loading: loading,
          onPressed: loading ? null : () => onSubmit(),
        ).animate().fadeIn(delay: 770.ms, duration: 400.ms).slideY(
              begin: 0.06,
              end: 0,
            ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.tr('auth.haveAccount'),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.palette.textMuted,
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => context.router.maybePop(),
              child: Text(
                context.tr('auth.login'),
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 800.ms, duration: 400.ms),
      ],
    );
  }
}
