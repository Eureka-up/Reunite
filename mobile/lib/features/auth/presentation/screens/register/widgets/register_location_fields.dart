import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/widgets/app_dropdown.dart';

/// Governorate -> city dropdowns for register.
///
/// Data comes from [LocationsRepository] via the form controller
/// (API in real mode, bundled fallback offline).
/// Governorate is UI-only (filters the city list).
/// Only the selected city is sent to the API.
class RegisterLocationFields extends StatelessWidget {
  const RegisterLocationFields({
    super.key,
    required this.governorates,
    required this.cities,
    required this.governorate,
    required this.city,
    required this.loading,
    required this.onGovernorateChanged,
    required this.onCityChanged,
  });

  final List<String> governorates;
  final List<String> cities;
  final String? governorate;
  final String? city;
  final bool loading;
  final ValueChanged<String?> onGovernorateChanged;
  final ValueChanged<String?> onCityChanged;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const LinearProgressIndicator();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppDropdown<String>(
          label: context.tr('auth.governorate'),
          hint: context.tr('auth.selectGovernorate'),
          icon: Icons.map_outlined,
          value: governorate,
          items: governorates
              .map((g) => DropdownMenuItem(value: g, child: Text(g)))
              .toList(),
          onChanged: onGovernorateChanged,
        ),
        const SizedBox(height: 12),
        AppDropdown<String>(
          label: context.tr('auth.city'),
          hint: context.tr('auth.selectCity'),
          icon: Icons.location_city_rounded,
          value: city,
          items: cities
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: governorate == null ? (_) {} : onCityChanged,
        ),
      ],
    );
  }
}
