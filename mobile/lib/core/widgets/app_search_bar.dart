import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';

/// Large, rounded search input with clear + leading icon.
class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.onTap,
    this.autofocus = false,
    this.textInputAction,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.inputHeight,
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: context.palette.border),
        boxShadow: [
          BoxShadow(
            color: context.palette.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: AppDimens.md),
          Icon(Icons.search_rounded, color: context.palette.textMuted),
          const SizedBox(width: AppDimens.sm),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              autofocus: autofocus,
              readOnly: readOnly,
              enabled: enabled,
              textInputAction: textInputAction,
              onSubmitted: onSubmitted,
              textAlignVertical: TextAlignVertical.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.palette.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: context.palette.textMuted,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          _ClearButton(controller: controller, onChanged: onChanged),
          const SizedBox(width: AppDimens.sm),
        ],
      ),
    );
  }
}

class _ClearButton extends StatefulWidget {
  const _ClearButton({this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  State<_ClearButton> createState() => _ClearButtonState();
}

class _ClearButtonState extends State<_ClearButton> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    if (controller == null) return const SizedBox(width: AppDimens.xl);
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.text.isEmpty) {
          return const SizedBox(width: AppDimens.xl);
        }
        return IconButton(
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.close, size: 18),
          color: context.palette.textMuted,
          onPressed: () {
            controller.clear();
            widget.onChanged?.call('');
          },
        );
      },
    );
  }
}