import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/widgets/widgets.dart';
import 'widgets/success_icon.dart';
import 'widgets/confirmation_content.dart';

@RoutePage()
class ReportConfirmationScreen extends StatelessWidget {
  const ReportConfirmationScreen({super.key, required this.caseId});

  final String caseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.xxl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ConfirmationSuccessIcon(),
              const SizedBox(height: AppDimens.xxl),
              const ConfirmationTitles(),
              const SizedBox(height: AppDimens.xxl),
              CaseIdCard(caseId: caseId),
              const Spacer(),
              AppButton(
                label: context.tr('report.backHome'),
                gradient: AppColors.brandGradient,
                onPressed: () =>
                    context.router.replaceAll([const AppShellRoute()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
