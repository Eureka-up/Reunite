import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.page,
    required this.finishing,
    required this.onNext,
  });

  final int page;
  final bool finishing;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 3; i++)
                AnimatedContainer(
                  duration: 300.ms,
                  curve: Curves.easeOutCubic,
                  margin: EdgeInsetsDirectional.only(end: i == 2 ? 0 : 8),
                  width: page == i ? 32 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: page == i ? AppColors.brandGradient : null,
                    color: page == i ? null : context.palette.border,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          AppButton(
            label: page == 2
                ? context.tr('onboarding.start')
                : context.tr('onboarding.next'),
            gradient: AppColors.brandGradient,
            icon: page == 2
                ? Icons.check_rounded
                : Icons.arrow_forward_rounded,
            loading: finishing,
            onPressed: finishing ? null : onNext,
          )
              .animate(key: ValueKey('btn-$page-$finishing'))
              .fadeIn(duration: 280.ms)
              .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shield_rounded,
                size: 14,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 6),
              Text(
                'آمن  •  مشفّر  •  بإشراف مجتمعي',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.palette.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
