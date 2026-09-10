import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/services/location_service.dart';
import '../../../core/utils/debouncer.dart';
import '../../reports/domain/child_case.dart';
import '../../reports/data/repositories/child_case_repository.dart';
import '../../shared/domain/app_enums.dart';

sealed class MissingState extends Equatable {
  const MissingState();

  @override
  List<Object?> get props => [];
}

class MissingLoading extends MissingState {
  const MissingLoading();
}

class MissingLoaded extends MissingState {
  const MissingLoaded({
    required this.cases,
    this.loading = false,
    this.failure,
  });

  final List<ChildCase> cases;
  final bool loading;
  final AppFailure? failure;

  MissingLoaded copyWith({
    List<ChildCase>? cases,
    bool? loading,
    AppFailure? failure,
  }) {
    return MissingLoaded(
      cases: cases ?? this.cases,
      loading: loading ?? this.loading,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [cases, loading, failure];
}

class MissingCubit extends Cubit<MissingState> {
  MissingCubit(this._repo, {required LocationService location})
      : _location = location,
        super(const MissingLoading()) {
    _debouncer = Debouncer();
    load();
  }

  final ChildCaseRepository _repo;
  final LocationService _location;
  late final Debouncer _debouncer;

  CasesQuery _query = const CasesQuery();
  String _search = '';
  LatLng? _userLocation;

  @override
  Future<void> close() {
    _debouncer.dispose();
    return super.close();
  }

  Future<void> load() async {
    emit(const MissingLoading());
    try {
      if (_userLocation == null) {
        try {
          final pos = await _location.getCurrentPosition();
          _userLocation = toLatLng(pos);
        } on AppFailure {
          _userLocation = null;
        }
      }
      final cases = await _repo.getMissing(_query);
      emit(MissingLoaded(cases: cases));
    } on AppFailure catch (e) {
      emit(MissingLoaded(cases: const [], failure: e));
    }
  }

  void onSearch(String value) {
    _search = value;
    _debouncer.run(() {
      _query = _query.copyWith(search: _search.isEmpty ? null : value);
      load();
    });
  }

  void setGender(Gender? gender) {
    _query = _query.copyWith(gender: gender, search: _query.search);
    load();
  }

  void toggleStatusFilter({bool activeOnly = false, bool foundOnly = false}) {
    _query = CasesQuery(
      search: _query.search,
      gender: _query.gender,
      activeOnly: activeOnly,
      foundOnly: foundOnly,
    );
    load();
  }

  void toggleSort(bool newest) {
    _query = _query.copyWith(sortNewest: newest);
    load();
  }

  void clearFilters() {
    _query = const CasesQuery();
    load();
  }

  double? distanceTo(ChildCase c) {
    final loc = _userLocation;
    final coords = c.coordinates;
    if (loc == null || coords == null) return null;
    return loc.distanceMetersTo(coords);
  }
}
