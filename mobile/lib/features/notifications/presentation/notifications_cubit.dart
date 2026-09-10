import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../notifications/domain/app_notification.dart';
import '../../notifications/data/notifications_repository.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded(this.items);
  final List<AppNotification> items;

  int get unreadCount => items.where((n) => !n.read).length;

  @override
  List<Object?> get props => [items];
}

class NotificationsError extends NotificationsState {
  const NotificationsError(this.failure);
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repo) : super(const NotificationsLoading());

  final NotificationsRepository _repo;

  Future<void> load() async {
    emit(const NotificationsLoading());
    try {
      final items = await _repo.getAll();
      emit(NotificationsLoaded(items));
    } on AppFailure catch (e) {
      emit(NotificationsError(e));
    }
  }

  Future<void> markAllRead() async {
    final current = state;
    if (current is! NotificationsLoaded) return;
    await _repo.markAllRead();
    final updated = current.items
        .map((n) => n.copyWith(read: true))
        .toList();
    emit(NotificationsLoaded(updated));
  }
}