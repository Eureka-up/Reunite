import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/widgets/widgets.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.initialName,
    required this.onSave,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String initialName;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppAvatar(label: initialName.isEmpty ? 'ع' : initialName.substring(0, 1), radius: 32),
          const SizedBox(height: AppDimens.xxl),
          AppTextField(
            controller: nameController,
            icon: Icons.person_outline_rounded,
            hint: context.tr('auth.fullName'),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.tr('validation.required')
                : null,
          ),
          const SizedBox(height: AppDimens.lg),
          AppTextField(
            controller: phoneController,
            icon: Icons.phone_outlined,
            hint: context.tr('auth.phone'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppDimens.xl),
          AppButton(
            label: context.tr('common.save'),
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}
