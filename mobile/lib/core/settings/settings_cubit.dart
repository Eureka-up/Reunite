import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../storage/stores.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required this.themeMode,
    required this.language,
    required this.alertRadiusMeters,
    required this.pushEnabled,
    required this.notifyNearby,
    required this.notifyUpdates,
    required this.notifyMatches,
  });

  final ThemeMode themeMode;
  final Locale language;
  final int alertRadiusMeters;
  final bool pushEnabled;
  final bool notifyNearby;
  final bool notifyUpdates;
  final bool notifyMatches;

  ThemeMode get effectiveThemeMode => themeMode;

  @override
  List<Object?> get props => [
        themeMode,
        language,
        alertRadiusMeters,
        pushEnabled,
        notifyNearby,
        notifyUpdates,
        notifyMatches,
      ];
}

class AppSettingsCubit extends Cubit<SettingsState> {
  AppSettingsCubit(this._prefs) : super(_restore(_prefs));

  final PrefsStore _prefs;

  static SettingsLoaded _restore(PrefsStore prefs) {
    final ThemeMode mode = switch (prefs.themeMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    final Locale locale = switch (prefs.locale) {
      'ar' => const Locale('ar'),
      'en' => const Locale('en'),
      _ => const Locale('ar'),
    };
    return SettingsLoaded(
      themeMode: mode,
      language: locale,
      alertRadiusMeters: prefs.alertRadiusMeters,
      pushEnabled: prefs.pushEnabled,
      notifyNearby: prefs.notifyNearby,
      notifyUpdates: prefs.notifyUpdates,
      notifyMatches: prefs.notifyMatches,
    );
  }

  void setThemeMode(ThemeMode mode) {
    _prefs.themeMode = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => null,
    };
    emit(_restore(_prefs));
  }

  void setLanguage(Locale locale) {
    _prefs.locale = locale.languageCode;
    emit(_restore(_prefs));
  }

  void setAlertRadius(int meters) {
    _prefs.alertRadiusMeters = meters;
    emit(_restore(_prefs));
  }

  void setPushEnabled(bool value) {
    _prefs.pushEnabled = value;
    emit(_restore(_prefs));
  }

  void setNotifyNearby(bool value) {
    _prefs.notifyNearby = value;
    emit(_restore(_prefs));
  }

  void setNotifyUpdates(bool value) {
    _prefs.notifyUpdates = value;
    emit(_restore(_prefs));
  }

  void setNotifyMatches(bool value) {
    _prefs.notifyMatches = value;
    emit(_restore(_prefs));
  }
}
