import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/services/location_service.dart';
import '../../reports/domain/child_case.dart';
import '../../reports/data/repositories/child_case_repository.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.emergency,
    required this.nearby,
    required this.stats,
    required this.userLocation,
  });

  final List<ChildCase> emergency;
  final List<ChildCase> nearby;
  final CaseStatistics stats;
  final LatLng? userLocation;

  @override
  List<Object?> get props => [emergency, nearby, stats, userLocation];
}

class HomeError extends HomeState {
  const HomeError(this.failure);
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}

class HomeEmpty extends HomeState {}

class HomeEvent {}

class LoadHome extends HomeEvent {}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo, {required LocationService location})
      : _location = location,
        super(const HomeLoading());

  final ChildCaseRepository _repo;
  final LocationService _location;
  LatLng? _userLocation;

  Future<void> load() async {
    emit(const HomeLoading());
    try {
      LatLng? loc;
      try {
        final pos = await _location.getCurrentPosition();
        loc = toLatLng(pos);
      } on AppFailure {
        loc = null;
      }
      _userLocation = loc;

      final all = await _repo.getMissing(const CasesQuery());
      final emergency = all.where((c) => c.isUrgent).toList();
      final stats = await _repo.getStatistics();

      List<ChildCase> nearby = [];
      if (loc != null) {
        nearby = await _repo.getNearby(loc);
      }

      emit(HomeLoaded(
        emergency: emergency,
        nearby: nearby,
        stats: stats,
        userLocation: loc,
      ));
    } on AppFailure catch (e) {
      emit(HomeError(e));
    }
  }

  double? distanceTo(ChildCase c) {
    final loc = _userLocation;
    final coords = c.coordinates;
    if (loc == null || coords == null) return null;
    return loc.distanceMetersTo(coords);
  }
}