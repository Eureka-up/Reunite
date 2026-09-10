import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../register_form_controller.dart';
import 'register_modern_password_input.dart';
import 'register_section_label.dart';

class RegisterPasswordFields extends StatelessWidget {
  const RegisterPasswordFields({super.key, required this.controller});

  final RegisterFormController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const RegisterSectionLabel(
          icon: Icons.lock_outline_rounded,
          label: 'كلمة المرور',
        ).animate().fadeIn(delay: 650.ms, duration: 400.ms),
        const SizedBox(height: 14),
        RegisterModernPasswordInput(
          label: context.tr('auth.password'),
          controller: controller.password,
          delay: 680,
          validator: (v) => (v ?? '').length >= 8
              ? null
              : context.tr('validation.passwordMin'),
        ),
        RegisterModernPasswordInput(
          label: context.tr('auth.confirmPassword'),
          controller: controller.confirm,
          delay: 710,
          validator: (v) => v == controller.password.text
              ? null
              : context.tr('validation.passwordMatch'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
