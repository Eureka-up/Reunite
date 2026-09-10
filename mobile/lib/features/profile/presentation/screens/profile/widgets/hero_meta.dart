import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';

class HeroMeta extends StatelessWidget {
  const HeroMeta({super.key, required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 12, color: Colors.white.withValues(alpha: 0.8)), const SizedBox(width: 4), Text(value, style: context.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, height: 1))]),
          const SizedBox(height: 2),
          Text(label, style: context.textTheme.labelSmall?.copyWith(color: Colors.white.withValues(alpha: 0.68), fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
