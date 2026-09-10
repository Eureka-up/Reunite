import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/services/location_service.dart';
import '../../reports/domain/child_case.dart';
import '../../reports/data/repositories/child_case_repository.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapLoading extends MapState {
  const MapLoading();
}

class MapLoaded extends MapState {
  const MapLoaded({
    required this.userLocation,
    required this.missing,
    required this.found,
    required this.radiusMeters,
  });

  final LatLng? userLocation;
  final List<ChildCase> missing;
  final List<ChildCase> found;
  final int radiusMeters;

  @override
  List<Object?> get props => [userLocation, missing, found, radiusMeters];
}

class MapError extends MapState {
  const MapError(this.failure);
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}

class MapCubit extends Cubit<MapState> {
  MapCubit(this._repo, {required LocationService location})
      : _location = location,
        super(const MapLoading());

  final ChildCaseRepository _repo;
  final LocationService _location;

  void load({int radiusMeters = 5000}) => _load(radiusMeters: radiusMeters);

  Future<void> _load({required int radiusMeters}) async {
    emit(const MapLoading());
    try {
      LatLng? loc;
      try {
        final pos = await _location.getCurrentPosition();
        loc = toLatLng(pos);
      } on AppFailure {
        loc = null;
      }
      final missing = await _repo.getMissing(const CasesQuery(activeOnly: true));
      final found = await _repo.getFound();
      emit(MapLoaded(
        userLocation: loc,
        missing: missing,
        found: found,
        radiusMeters: radiusMeters,
      ));
    } on AppFailure catch (e) {
      emit(MapError(e));
    }
  }
}
