import 'package:flutter/material.dart';

import '../../../../domain/child_case.dart';
import 'hero_backdrop.dart';
import 'hero_name_card.dart';

export 'glass_btn.dart';
export 'hero_backdrop.dart';
export 'hero_name_card.dart';

/// Thin hero composition. Backdrop + name card live in their own files
/// so this file stays under the 150-line budget. No logic changes.
class ModernHero extends StatelessWidget {
  const ModernHero({super.key, required this.caseData});
  final ChildCase caseData;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 416,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            HeroBackdrop(caseData: caseData),
            HeroNameCard(caseData: caseData),
          ],
        ),
      ),
    );
  }
}
