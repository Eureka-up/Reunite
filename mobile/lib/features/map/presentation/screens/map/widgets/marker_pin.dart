import 'package:flutter/material.dart';

class MarkerPin extends StatelessWidget {
  const MarkerPin({super.key, required this.color, required this.icon, this.onTap});

  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 12, spreadRadius: 1),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
