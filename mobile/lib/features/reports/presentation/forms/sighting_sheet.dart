import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/child_case.dart';
import '../details_cubit.dart';

/// Opens the "I saw this child" reporting sheet.
Future<void> showSightingSheet(BuildContext context, ChildCase caseData) {
  return showAppBottomSheet<void>(
    context,
    child: SightingSheet(caseData: caseData),
  );
}

class SightingSheet extends StatefulWidget {
  const SightingSheet({super.key, required this.caseData});

  final ChildCase caseData;

  @override
  State<SightingSheet> createState() => _SightingSheetState();
}

class _SightingSheetState extends State<SightingSheet> {
  final _formKey = GlobalKey<FormState>();
  final _description = TextEditingController();
  final _notes = TextEditingController();
  DateTime _occurredAt = DateTime.now();
  bool _submitting = false;

  @override
  void dispose() {
    _description.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);
    await context.read<DetailsCubit>().reportSighting(
          latitude: 30.0444,
          longitude: 31.2357,
          occurredAt: _occurredAt,
          description: _description.text.trim(),
        );
    if (!context.mounted) return;
    setState(() => _submitting = false);
    Navigator.pop(context);
    showAppSnackbar(
      context,
      text: context.tr('report.confirmationTitle'),
      type: SnackBarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: AppColors.emergencyGradient,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: const Icon(Icons.visibility_rounded,
                color: Colors.white, size: 26),
          ),
          const SizedBox(height: AppDimens.md),
          Text(context.tr('details.sightingTitle'),
              style: context.textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(
            context.tr('details.sightingSubtitle'),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.palette.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.xl),
          AppTextField(
            icon: Icons.schedule_rounded,
            hint: context.tr('details.sightingTime'),
            enabled: false,
          ),
          const SizedBox(height: AppDimens.lg),
          AppTextField(
            controller: _description,
            icon: Icons.notes_rounded,
            hint: context.tr('details.sightingDescription'),
            maxLines: 3,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.tr('validation.required')
                : null,
          ),
          const SizedBox(height: AppDimens.lg),
          AppTextField(
            controller: _notes,
            icon: Icons.sticky_note_2_outlined,
            hint: context.tr('details.sightingNotes'),
            maxLines: 2,
          ),
          const SizedBox(height: AppDimens.xl),
          AppButton(
            label: context.tr('details.submitSighting'),
            gradient: AppColors.emergencyGradient,
            loading: _submitting,
            onPressed: _submitting ? null : _submit,
          ),
        ],
      ),
    );
  }
}
