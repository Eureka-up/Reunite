import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../onboarding_controller.dart';
import '../onboarding_data.dart';
import 'onboard_slide.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
    required this.controller,
    required this.page,
    required this.onPageChanged,
  });

  final OnboardingController controller;
  final int page;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller.pages,
        itemCount: 3,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final active = index == page;
          return AnimatedOpacity(
            duration: 320.ms,
            opacity: active ? 1 : 0.6,
            child: OnboardSlide(
              index: index,
              icon: OnboardingData.icons[index],
              accent: OnboardingData.accents[index],
              eyebrow: OnboardingData.eyebrows[index],
              title: context.tr(OnboardingData.titles[index]),
              subtitle: context.tr(OnboardingData.subtitles[index]),
              features: OnboardingData.features[index],
              active: active,
            ),
          );
        },
      ),
    );
  }
}
