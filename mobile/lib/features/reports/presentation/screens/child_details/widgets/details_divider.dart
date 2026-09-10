import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';

/// Thin divider used between info rows, extracted from `info_group.dart`.
class DetailsDivider extends StatelessWidget {
  const DetailsDivider({super.key});
  @override
  Widget build(BuildContext context) => Divider(
        height: 1,
        thickness: 1,
        color: context.palette.border.withValues(alpha: 0.65),
        indent: 62,
      );
}
