import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

// ── Modern input field ──
class LoginModernInput extends StatelessWidget {
  const LoginModernInput({super.key, 
    required this.label,
    required this.icon,
    required this.controller,
    required this.delay,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final int delay;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.palette.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                validator: validator,
                autofillHints: autofillHints,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.palette.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: label,
                  prefixIcon: Icon(
                    icon,
                    size: 20,
                    color: context.palette.textMuted,
                  ),
                  filled: true,
                  fillColor: context.palette.surfaceAlt.withValues(alpha: 0.4),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.emergency,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.emergency,
                      width: 1.5,
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: delay.ms, duration: 400.ms)
              .slideY(begin: 0.04, end: 0),
        ],
      ),
    );
  }
}
