import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';
import 'add_button.dart';
import 'nav_item.dart';

class ModernNav extends StatelessWidget {
  const ModernNav({super.key, required this.current, required this.onTap, required this.onAdd});
  final int current;
  final ValueChanged<int> onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: context.palette.surface.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: context.palette.border.withValues(alpha: 0.9)),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 10))],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  NavItem(icon: Icons.home_rounded, label: context.tr('bottomNav.home'), selected: current == 0, onTap: () => onTap(0)),
                  NavItem(icon: Icons.search_rounded, label: context.tr('bottomNav.explore'), selected: current == 1, onTap: () => onTap(1)),
                  // Center add — compact, not overlapping
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: AddButton(onTap: onAdd),
                  ),
                  NavItem(icon: Icons.notifications_none_rounded, activeIcon: Icons.notifications_rounded, label: context.tr('bottomNav.notifications'), selected: current == 3, onTap: () => onTap(3), showDot: true),
                  NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: context.tr('bottomNav.profile'), selected: current == 4, onTap: () => onTap(4)),
                  const SizedBox(width: 6),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
