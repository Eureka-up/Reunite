import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/di/app_di.dart';
import '../../../core/storage/stores.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/domain/user.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileState {
  const ProfileError(this.failure);
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(const ProfileLoading());

  final AuthRepository _repo;

  Future<void> load() async {
    emit(const ProfileLoading());
    try {
      final user = await _repo.currentUser();
      emit(ProfileLoaded(user ?? const User(id: 'guest', fullName: 'ضيف')));
    } on AppFailure catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> update({
    String? fullName,
    String? phone,
    String? Function()? photoPath,
  }) async {
    try {
      final user = await _repo.updateProfile(
        fullName: fullName,
        phone: phone,
        photoPath: photoPath,
      );
      emit(ProfileLoaded(user));
    } on AppFailure catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    getIt<AuthStore>()
      ..clear()
      ..saveGuest();
  }
}
