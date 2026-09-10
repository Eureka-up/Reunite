import 'package:flutter/material.dart';

import '../../../../../shared/domain/app_enums.dart';
import 'missing_photo_step.dart';
import 'missing_basic_step.dart';
import 'missing_date_step.dart';
import 'missing_appearance_step.dart';
import 'missing_contact_step.dart';
import 'missing_review_step.dart';

/// Step-body dispatch for the missing flow, extracted from `missing_view.dart`.
/// Takes already-owned controllers/values so the shell stays under budget.
class MissingStepsBody extends StatelessWidget {
  const MissingStepsBody({
    super.key,
    required this.step,
    required this.name,
    required this.age,
    required this.lastLocation,
    required this.city,
    required this.area,
    required this.clothing,
    required this.marks,
    required this.description,
    required this.phone,
    required this.email,
    required this.missingDateLabel,
    required this.gender,
    required this.photoSeed,
    required this.onPhotoChanged,
    required this.onGender,
    required this.onPickDate,
  });

  final int step;
  final TextEditingController name;
  final TextEditingController age;
  final TextEditingController lastLocation;
  final TextEditingController city;
  final TextEditingController area;
  final TextEditingController clothing;
  final TextEditingController marks;
  final TextEditingController description;
  final TextEditingController phone;
  final TextEditingController email;
  final String missingDateLabel;
  final Gender? gender;
  final String? photoSeed;
  final ValueChanged<String?> onPhotoChanged;
  final ValueChanged<Gender> onGender;
  final VoidCallback onPickDate;

  @override
  Widget build(BuildContext context) {
    return Column(
        key: ValueKey(step),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          switch (step) {
            0 => MissingPhotoStep(
                photoSeed: photoSeed, onPhotoChanged: onPhotoChanged),
            1 => MissingBasicStep(
                name: name, age: age, gender: gender, onGender: onGender),
            2 => MissingDateStep(
                missingDate: DateTime.now(),
                dateLabel: missingDateLabel,
                onPickDate: onPickDate,
                lastLocation: lastLocation,
                city: city,
                area: area),
            3 => MissingAppearanceStep(
                clothing: clothing, marks: marks, description: description),
            4 => MissingContactStep(phone: phone, email: email),
            _ => MissingReviewStep(
                name: name.text,
                age: age.text,
                gender: gender,
                city: city.text,
                area: area.text,
                clothing: clothing.text,
                phone: phone.text),
          }
        ]);
  }
}
