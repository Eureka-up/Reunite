import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';

class ReportAction extends StatelessWidget {
  const ReportAction({super.key, required this.icon, required this.label, required this.sub, required this.grad, required this.onTap});
  final IconData icon;
  final String label;
  final String sub;
  final Gradient grad;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: context.palette.border), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))]),
            child: Column(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(gradient: grad, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: Colors.white, size: 24)),
              const SizedBox(height: 10),
              Text(label, textAlign: TextAlign.center, style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 12.5, height: 1.2)),
              const SizedBox(height: 2),
              Text(sub, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textSecondary, fontSize: 11)),
            ]),
          ),
        ),
      ),
    );
  }
}
