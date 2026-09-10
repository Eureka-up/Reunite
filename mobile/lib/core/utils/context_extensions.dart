import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

extension AppContext on BuildContext {
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  AppPalette get palette => AppPalette.of(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isTablet => screenWidth >= 700;
}