import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';

class FoundSectionCard extends StatelessWidget {
  const FoundSectionCard({super.key, required this.icon, required this.color, required this.title, required this.subtitle, required this.child});
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: context.palette.border), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 14, offset: const Offset(0, 6))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Container(width: 38, height: 38, decoration: BoxDecoration(color: color.withValues(alpha: 0.11), borderRadius: BorderRadius.circular(11)), child: Icon(icon, size: 20, color: color)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)), Text(subtitle, style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary, fontSize: 12))]))]),
        const SizedBox(height: 16),
        child,
      ]),
    );
  }
}
