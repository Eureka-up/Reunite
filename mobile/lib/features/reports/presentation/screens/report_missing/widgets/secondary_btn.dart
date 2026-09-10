import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class MissingSecondaryBtn extends StatelessWidget {
  const MissingSecondaryBtn({super.key, required this.icon, required this.label, required this.onTap, this.outlined = false});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: outlined
          ? OutlinedButton.icon(onPressed: onTap, icon: Icon(icon, size: 18), label: Text(label, style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)), style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), side: BorderSide(color: context.palette.border)))
          : ElevatedButton.icon(onPressed: onTap, icon: Icon(icon, size: 18, color: Colors.white), label: Text(label, style: context.textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
    );
  }
}
