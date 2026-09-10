import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../profile_cubit.dart';

class ModernLogout extends StatelessWidget {
  const ModernLogout({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final ok = await showAppConfirmDialog(context, title: context.tr('profile.logout'), message: context.tr('profile.logout'), destructive: true);
          if (ok == true && context.mounted) {
            await context.read<ProfileCubit>().logout();
            if (context.mounted) context.router.replaceAll([const OnboardingRoute()]);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 52,
          decoration: BoxDecoration(color: AppColors.emergency.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.emergency.withValues(alpha: 0.16))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Icon(Icons.logout_rounded, size: 18, color: AppColors.emergency), const SizedBox(width: 8), Text(context.tr('profile.logout'), style: context.textTheme.titleSmall?.copyWith(color: AppColors.emergency, fontWeight: FontWeight.w800))],
          ),
        ),
      ),
    );
  }
}
