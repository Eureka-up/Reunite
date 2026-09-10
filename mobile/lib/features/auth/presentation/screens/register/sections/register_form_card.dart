import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/utils/context_extensions.dart';
import '../register_form_controller.dart';
import '../widgets/register_brand_avatar.dart';
import '../widgets/register_form_actions.dart';
import '../widgets/register_password_fields.dart';
import '../widgets/register_personal_fields.dart';

class RegisterFormCard extends StatelessWidget {
  const RegisterFormCard({
    super.key,
    required this.controller,
    required this.loading,
    required this.topOffset,
  });

  final RegisterFormController controller;
  final bool loading;
  final double topOffset;

  Future<void> _submit(BuildContext context) => controller.submit(context);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topOffset,
      left: 16,
      right: 16,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: context.palette.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 40,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 28,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const RegisterBrandAvatar(),
                  const SizedBox(height: 20),
                  Text(
                    context.tr('auth.createAccount'),
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: context.palette.textPrimary,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 400.ms)
                      .slideY(begin: 0.08, end: 0),
                  const SizedBox(height: 24),
                  RegisterPersonalFields(controller: controller),
                  RegisterPasswordFields(controller: controller),
                  ListenableBuilder(
                    listenable: controller,
                    builder: (context, _) {
                      return RegisterFormActions(
                        controller: controller,
                        loading: loading,
                        onSubmit: () => _submit(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ).animate().fadeIn(delay: 400.ms, duration: 500.ms).slideY(
            begin: 0.06,
            end: 0,
          ),
    );
  }
}
