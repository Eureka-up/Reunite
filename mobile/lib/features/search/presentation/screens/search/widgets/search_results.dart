import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({
    super.key,
    required this.query,
    required this.results,
    required this.recent,
  });

  final String query;
  final List<dynamic> results;
  final List<String> recent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
          child: Text(
            '${results.length} ${context.tr('missing.title')}',
            style: context.textTheme.labelMedium?.copyWith(
              color: context.palette.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: AppDimens.sm),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final caseData = results[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppDimens.md),
                child: ChildCaseCard(
                  caseData: caseData,
                  onTap: () => context.router
                      .push(ChildDetailsRoute(caseId: caseData.id)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
