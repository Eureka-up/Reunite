import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

/// Footer nav (back/next-publish), extracted from `missing_view.dart`.
class MissingFooter extends StatelessWidget {
  const MissingFooter({
    super.key,
    required this.step,
    required this.submitting,
    required this.onBack,
    required this.onNext,
  });
  final int step;
  final bool submitting;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.palette.surface,
          border: Border(top: BorderSide(color: context.palette.border)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, -6)),
          ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              if (step > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: onBack,
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        side: BorderSide(color: context.palette.border)),
                    child: Text(context.tr('common.back'),
                        style: context.textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                ),
              if (step > 0) const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 52,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFF0F172A),
                          Color(0xFF009688)
                        ]),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.22),
                              blurRadius: 14,
                              offset: const Offset(0, 6)),
                        ]),
                    child: ElevatedButton(
                      onPressed: submitting ? null : onNext,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: submitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                      step == 5
                                          ? context.tr('report.publishMissing')
                                          : context.tr('common.next'),
                                      style: context.textTheme.labelLarge
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800)),
                                  const SizedBox(width: 8),
                                  Icon(
                                      step == 5
                                          ? Icons.send_rounded
                                          : Icons.arrow_forward_rounded,
                                      size: 18,
                                      color: Colors.white),
                                ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
