import 'package:flutter/material.dart';
import '../../../../../../core/utils/context_extensions.dart';

// ── Social circle button ──
class LoginSocialCircle extends StatelessWidget {
  const LoginSocialCircle({super.key, 
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: context.palette.surfaceAlt.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 2),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.palette.textMuted,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
