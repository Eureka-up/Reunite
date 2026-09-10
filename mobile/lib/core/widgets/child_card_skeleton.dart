import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';
import 'app_skeleton.dart';

/// Skeleton child cards for loading lists.
class ChildCardSkeleton extends StatelessWidget {
  const ChildCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(color: context.palette.border),
      ),
      child: Row(
        children: [
          const AppSkeleton(width: 84, height: 84, radius: 16),
          const SizedBox(width: AppDimens.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppSkeleton(width: 120, height: 18),
                SizedBox(height: 8),
                AppSkeleton(width: 90, height: 14),
                SizedBox(height: 14),
                AppSkeleton(width: 160, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
