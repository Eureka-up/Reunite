import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';

class MapRoundButton extends StatelessWidget {
  const MapRoundButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.palette.surface,
      shape: const CircleBorder(),
      elevation: 4,
      child: IconButton(
        icon: Icon(icon, color: context.palette.textPrimary),
        onPressed: onTap,
      ),
    );
  }
}
