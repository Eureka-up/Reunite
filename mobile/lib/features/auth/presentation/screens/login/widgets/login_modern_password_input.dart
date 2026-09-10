import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';



// ── Modern password input ──
class LoginModernPasswordInput extends StatefulWidget {
  const LoginModernPasswordInput({super.key, 
    required this.label,
    required this.controller,
    required this.delay,
    this.textInputAction,
    this.onSubmitted,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final int delay;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;

  @override
  State<LoginModernPasswordInput> createState() => _LoginModernPasswordInputState();
}

class _LoginModernPasswordInputState extends State<LoginModernPasswordInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.palette.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
                controller: widget.controller,
                obscureText: _obscure,
                textInputAction: widget.textInputAction,
                validator: widget.validator,
                onFieldSubmitted: widget.onSubmitted,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.palette.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: widget.label,
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: context.palette.textMuted,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Icon(
                      _obscure
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: 20,
                      color: context.palette.textMuted,
                    ),
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
              .fadeIn(delay: widget.delay.ms, duration: 400.ms)
              .slideY(begin: 0.04, end: 0),
        ],
      ),
    );
  }
}
