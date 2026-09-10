import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class OnboardingData {
  const OnboardingData._();

  static const titles = [
    'onboarding.title1',
    'onboarding.title2',
    'onboarding.title3',
  ];

  static const subtitles = [
    'onboarding.subtitle1',
    'onboarding.subtitle2',
    'onboarding.subtitle3',
  ];

  static const accents = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.accent,
  ];

  static const icons = [
    Icons.favorite_rounded,
    Icons.how_to_reg_rounded,
    Icons.map_rounded,
  ];

  static const eyebrows = ['مجتمع متكاتف', 'كل تفصيل مهم', 'لحظي وذكي'];

  static const features = [
    ['نشر سريع للبلاغات', 'تحقق من الفريق قبل النشر', 'وصول واسع للمجتمع'],
    ['إضافة صور ومعلومات دقيقة', 'تواصل آمن مع المبلّغ', 'مشاركة بضغطة واحدة'],
    ['تنبيه عند بلاغ قريب منك', 'تخصيص نطاق التنبيه', 'متابعة حالة البلاغ'],
  ];
}
