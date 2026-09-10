import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../login_form_controller.dart';
import 'login_modern_input.dart';
import 'login_modern_password_input.dart';

class LoginFormFields extends StatelessWidget {
  const LoginFormFields({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  final LoginFormController controller;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LoginModernInput(
          label: context.tr('auth.email'),
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          controller: controller.identifier,
          delay: 550,
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return context.tr('validation.required');
            }
            return null;
          },
        ),
        LoginModernPasswordInput(
          label: context.tr('auth.password'),
          controller: controller.password,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onSubmit(),
          delay: 600,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return context.tr('validation.required');
            }
            return null;
          },
        ),
      ],
    );
  }
}
