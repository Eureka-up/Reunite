import 'package:equatable/equatable.dart';

/// Typed domain failures. UI listens to the [messageKey] to localize text,
/// so no user-facing strings leak into business layers.
sealed class AppFailure extends Equatable {
  const AppFailure({required this.messageKey, this.details});

  /// Localization key resolved in the UI layer.
  final String messageKey;

  /// Optional machine readable details for logs.
  final String? details;

  @override
  List<Object?> get props => [messageKey, details];
}

class ServerFailure extends AppFailure {
  const ServerFailure({super.details}) : super(messageKey: 'error.server');
}

class NetworkFailure extends AppFailure {
  const NetworkFailure({super.details}) : super(messageKey: 'error.network');
}

class TimeoutFailure extends AppFailure {
  const TimeoutFailure({super.details}) : super(messageKey: 'error.timeout');
}

class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure({super.details})
      : super(messageKey: 'error.unauthorized');
}

class NotFoundFailure extends AppFailure {
  const NotFoundFailure({super.details}) : super(messageKey: 'error.notFound');
}

class ValidationFailure extends AppFailure {
  const ValidationFailure({this.fieldMessages = const {}, super.details})
      : super(messageKey: 'error.validation');

  final Map<String, String> fieldMessages;

  @override
  List<Object?> get props => [messageKey, details, fieldMessages];
}

class CacheFailure extends AppFailure {
  const CacheFailure({super.details}) : super(messageKey: 'error.cache');
}

class PermissionDeniedFailure extends AppFailure {
  const PermissionDeniedFailure({super.details})
      : super(messageKey: 'error.permission');
}

class CanceledFailure extends AppFailure {
  const CanceledFailure({super.details}) : super(messageKey: 'error.canceled');
}