import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/storage/stores.dart';
import '../../../core/utils/debouncer.dart';
import '../../reports/domain/child_case.dart';
import '../../reports/data/repositories/child_case_repository.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchIdle extends SearchState {
  const SearchIdle();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchResults extends SearchState {
  const SearchResults({
    required this.query,
    required this.results,
    required this.recent,
  });

  final String query;
  final List<ChildCase> results;
  final List<String> recent;

  @override
  List<Object?> get props => [query, results, recent];
}

class SearchEmpty extends SearchState {
  const SearchEmpty({required this.recent});
  final List<String> recent;

  @override
  List<Object?> get props => [recent];
}

class SearchError extends SearchState {
  const SearchError(this.failure);
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}

/// Loads default (nearby/recents) when there is no query yet.
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._repo, {required CacheStore cache})
      : _cache = cache,
        super(const SearchLoading()) {
    _debouncer = Debouncer();
    loadInitial();
  }

  final ChildCaseRepository _repo;
  final CacheStore _cache;
  late final Debouncer _debouncer;

  static const _recentKey = 'recent_searches';

  void loadInitial() {
    emit(SearchEmpty(recent: _recent));
  }

  List<String> get _recent => _cache.readStringList(_recentKey);

  void search(String query) {
    final q = query.trim();
    emit(const SearchLoading());
    _debouncer.run(() => _run(q));
  }

  Future<void> _run(String q) async {
    if (q.isEmpty) {
      emit(SearchEmpty(recent: _recent));
      return;
    }
    try {
      final results = await _repo.getMissing(CasesQuery(search: q));
      final recent = _addRecent(q);
      if (results.isEmpty) {
        emit(SearchEmpty(recent: recent));
      } else {
        emit(SearchResults(query: q, results: results, recent: recent));
      }
    } on AppFailure catch (e) {
      emit(SearchError(e));
    }
  }

  List<String> _addRecent(String q) {
    final list = [_recent, [q]].expand((x) => x).toList();
    final unique = <String>[];
    for (final item in list) {
      if (!unique.contains(item)) unique.add(item);
    }
    final trimmed = unique.take(6).toList();
    _cache.writeStringList(_recentKey, trimmed);
    return trimmed;
  }

  void clearRecent() {
    _cache.writeStringList(_recentKey, []);
    final current = state;
    if (current is SearchEmpty) {
      emit(const SearchEmpty(recent: []));
    }
  }

  @override
  Future<void> close() {
    _debouncer.dispose();
    return super.close();
  }
}
