import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/widgets/widgets.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
      child: const Column(
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: AppSkeleton(height: 118, radius: 22)),
              SizedBox(width: 12),
              Expanded(child: AppSkeleton(height: 118, radius: 22)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: AppSkeleton(height: 118, radius: 22)),
              SizedBox(width: 12),
              Expanded(child: AppSkeleton(height: 118, radius: 22)),
            ],
          ),
          SizedBox(height: 24),
          AppSkeleton(height: 180, radius: 22),
          SizedBox(height: 16),
          ChildCardSkeleton(),
        ],
      ),
    ).animate().fadeIn(duration: 320.ms);
  }
}
