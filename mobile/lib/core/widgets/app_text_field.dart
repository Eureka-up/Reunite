import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';

/// Reusable text field with optional icon, validator and label.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.icon,
    this.suffix,
    this.obscure = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofillHints,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final IconData? icon;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String>? autofillHints;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      enabled: enabled,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: icon == null ? null : Icon(icon, size: 22),
        suffixIcon: suffix,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimens.lg,
          vertical: maxLines > 1 ? AppDimens.md + 4 : 15,
        ),
      ),
    );
  }
}

/// Password field with reveal toggle.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.hint,
    this.validator,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? hint;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      hint: widget.hint,
      obscure: _obscure,
      validator: widget.validator,
      icon: Icons.lock_outline,
      onFieldSubmitted: widget.onSubmitted,
      suffix: IconButton(
        tooltip: _obscure ? 'Show' : 'Hide',
        icon: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 20,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}