import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';

class PillMini extends StatelessWidget {
  const PillMini({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.13), borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.white.withValues(alpha: 0.14))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 11, color: Colors.white), const SizedBox(width: 4), Text(label, style: context.textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10))]),
    );
  }
}
