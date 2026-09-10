import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/context_extensions.dart';
import 'onboarding_controller.dart';
import 'widgets/onboarding_footer.dart';
import 'widgets/onboarding_page_view.dart';
import 'widgets/onboarding_top_bar.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingController _c = OnboardingController();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _next() {
    if (_c.page == 2) {
      _c.finish(context);
    } else {
      _c.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -120,
            right: -120,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.06),
              ),
            ),
          ),
          SafeArea(
            child: ListenableBuilder(
              listenable: _c,
              builder: (context, _) {
                return Column(
                  children: [
                    OnboardingTopBar(
                      finishing: _c.finishing,
                      onSkip: () => _c.finish(context),
                    ),
                    OnboardingPageView(
                      controller: _c,
                      page: _c.page,
                      onPageChanged: _c.onPageChanged,
                    ),
                    OnboardingFooter(
                      page: _c.page,
                      finishing: _c.finishing,
                      onNext: _next,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
