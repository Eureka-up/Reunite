import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';

class ToggleIcon extends StatelessWidget {
  const ToggleIcon({super.key, required this.icon, required this.selected, required this.onTap});
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? context.palette.surface : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 36,
          height: 32,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: selected ? context.palette.border : Colors.transparent)),
          child: Icon(icon, size: 18, color: selected ? context.colorScheme.primary : context.palette.textMuted),
        ),
      ),
    );
  }
}
