import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Consistent floating snackbar.
void showAppSnackbar(
  BuildContext context, {
  required String text,
  SnackBarType type = SnackBarType.info,
}) {
  final Color color = switch (type) {
    SnackBarType.success => AppColors.success,
    SnackBarType.error => AppColors.emergency,
    SnackBarType.warning => AppColors.warning,
    SnackBarType.info => AppColors.info,
  };
  final IconData icon = switch (type) {
    SnackBarType.success => Icons.check_circle,
    SnackBarType.error => Icons.error,
    SnackBarType.warning => Icons.warning_amber_rounded,
    SnackBarType.info => Icons.info,
  };

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
}

enum SnackBarType { success, error, warning, info }