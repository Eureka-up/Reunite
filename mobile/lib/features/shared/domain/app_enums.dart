/// Domain enums shared across features.
library;

enum Gender { male, female }

enum CaseStatus { reported, underReview, published, possibleSighting, childFound, caseClosed }

enum UrgencyLevel { high, medium, low }

enum ReportType { missing, found }

/// Theme modes that persist to prefs.
enum AppThemeMode { system, light, dark }

/// App language selection.
enum AppLanguage { system, arabic, english }

/// Notification categories.
enum AppNotificationType { emergency, caseUpdate, possibleMatch, success }

extension GenderX on Gender {
  String get key => switch (this) {
        Gender.male => 'gender.male',
        Gender.female => 'gender.female',
      };
}

extension CaseStatusX on CaseStatus {
  String get key => switch (this) {
        CaseStatus.reported => 'status.reported',
        CaseStatus.underReview => 'status.underReview',
        CaseStatus.published => 'status.published',
        CaseStatus.possibleSighting => 'status.possibleSighting',
        CaseStatus.childFound => 'status.childFound',
        CaseStatus.caseClosed => 'status.caseClosed',
      };

  bool get isActive =>
      this == CaseStatus.published || this == CaseStatus.possibleSighting;

  bool get isResolved =>
      this == CaseStatus.childFound || this == CaseStatus.caseClosed;
}

extension UrgencyX on UrgencyLevel {
  String get key => switch (this) {
        UrgencyLevel.high => 'urgency.high',
        UrgencyLevel.medium => 'urgency.medium',
        UrgencyLevel.low => 'urgency.low',
      };
}

extension AppNotificationTypeX on AppNotificationType {
  String get key => switch (this) {
        AppNotificationType.emergency => 'notifications.emergency',
        AppNotificationType.caseUpdate => 'notifications.caseUpdate',
        AppNotificationType.possibleMatch => 'notifications.possibleMatch',
        AppNotificationType.success => 'notifications.success',
      };
}