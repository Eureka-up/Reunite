import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/date_formats.dart';
import '../../domain/child_case.dart';

/// Shares a case through the device share sheet.
Future<void> shareCase(BuildContext context, ChildCase caseData) async {
  final text = [
    caseData.isMissing ? 'Missing: ' : 'Found: ',
    caseData.name,
    ' - ',
    '${caseData.age} y/o - ',
    '${caseData.area} - ',
    DateFormats.dateTime(caseData.missingSince),
  ].join();
  await Share.share(text, subject: caseData.name);
}
