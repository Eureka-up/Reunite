import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../domain/child_case.dart';
import '../../../../data/repositories/child_case_repository.dart';
import '../../../details_cubit.dart';
import 'details_hero.dart';
import 'quick_facts.dart';
import 'info_group.dart';
import 'map_card.dart';
import 'matches_section.dart';
import 'disclaimer.dart';
import 'floating_actions.dart';
import 'details_skeleton.dart';

class ModernDetailsView extends StatelessWidget {
  const ModernDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<DetailsCubit>().state;
    return Scaffold(
      backgroundColor: context.palette.background,
      body: switch (state) {
        DetailsError() => ErrorState(
          message: context.tr('errors.title'),
          onRetry: () => context.read<DetailsCubit>().load(),
        ),
        DetailsLoading() => const DetailsSkeleton(),
        DetailsLoaded(:final caseData, :final matches) => ModernContent(
          caseData: caseData,
          matches: matches,
        ),
      },
    );
  }
}

class ModernContent extends StatelessWidget {
  const ModernContent({super.key, required this.caseData, required this.matches});
  final ChildCase caseData;
  final List<PossibleMatch> matches;

  @override
  Widget build(BuildContext context) {
    final isResolved = caseData.isResolved;
    return Stack(
      children: [
        Positioned.fill(
          child: CustomScrollView(
            slivers: [
              ModernHero(caseData: caseData),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverList.list(
                  children: [
                    // Quick stats row
                    QuickFacts(caseData: caseData)
                        .animate()
                        .fadeIn(delay: 100.ms)
                        .slideY(begin: 0.04),
                    const SizedBox(height: 16),
                    // Info cards
                    InfoGroup(caseData: caseData)
                        .animate()
                        .fadeIn(delay: 140.ms)
                        .slideY(begin: 0.04),
                    if (caseData.coordinates != null) ...[
                      const SizedBox(height: 16),
                      MapModernCard(caseData: caseData)
                          .animate()
                          .fadeIn(delay: 180.ms),
                    ],
                    if (caseData.isMissing && !isResolved) ...[
                      const SizedBox(height: 16),
                      MatchesModern(
                        matches: matches,
                        caseData: caseData,
                      ).animate().fadeIn(delay: 220.ms),
                    ],
                    const SizedBox(height: 16),
                    const ModernDisclaimer().animate().fadeIn(delay: 260.ms),
                    const SizedBox(height: 110),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isResolved)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingActions(caseData: caseData),
          ),
      ],
    );
  }
}
