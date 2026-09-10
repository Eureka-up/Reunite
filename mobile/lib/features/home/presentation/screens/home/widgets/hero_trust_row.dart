import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';
import 'trust_avatar_stack.dart';

class HeroTrustRow extends StatelessWidget {
  const HeroTrustRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TrustAvatarStack(),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            context.tr('home.trustedNote'),
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.88),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Icon(Icons.verified_rounded, size: 16, color: Colors.white.withValues(alpha: 0.9)),
      ],
    );
  }
}
