import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../otp_controller.dart';

class OtpCodeInput extends StatelessWidget {
  const OtpCodeInput({super.key, required this.controller});

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (i) => OtpBox(
          controller: controller.boxes[i],
          focus: controller.focusNodes[i],
          onChanged: (v) => controller.onBoxChanged(v, i),
        ),
      ),
    );
  }
}

class OtpBox extends StatelessWidget {
  const OtpBox({
    super.key,
    required this.controller,
    required this.focus,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focus;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 58,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final filled = controller.text.isNotEmpty;
          return TextField(
            controller: controller,
            focusNode: focus,
            onChanged: onChanged,
            maxLength: 1,
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: filled
                  ? context.colorScheme.secondary
                  : context.palette.surface,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                borderSide: BorderSide(color: context.palette.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                borderSide: BorderSide(
                  color: context.colorScheme.secondary,
                  width: 1.8,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
