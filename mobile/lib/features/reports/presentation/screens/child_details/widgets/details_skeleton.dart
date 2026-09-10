import 'package:flutter/material.dart';

import '../../../../../../core/widgets/widgets.dart';

class DetailsSkeleton extends StatelessWidget {
  const DetailsSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        AppSkeleton(height: 340, radius: 26),
        SizedBox(height: 40),
        AppSkeleton(height: 16, radius: 8),
        SizedBox(height: 12),
        AppSkeleton(height: 80, radius: 16),
        SizedBox(height: 12),
        AppSkeleton(height: 140, radius: 16),
      ],
    );
  }
}
