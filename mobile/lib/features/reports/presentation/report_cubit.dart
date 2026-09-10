import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../data/repositories/child_case_repository.dart';
import '../domain/child_case.dart';

sealed class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportIdle extends ReportState {
  const ReportIdle(this.step);
  final int step;

  @override
  List<Object?> get props => [step];
}

class ReportSubmitting extends ReportState {
  const ReportSubmitting(this.step);
  final int step;

  @override
  List<Object?> get props => [step];
}

class ReportSubmitted extends ReportState {
  const ReportSubmitted(this.caseData);
  final ChildCase caseData;

  @override
  List<Object?> get props => [caseData];
}

class ReportError extends ReportState {
  const ReportError(this.failure);
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}

class ReportCubit extends Cubit<ReportState> {
  ReportCubit(this._repo, {required this.isMissing})
      : super(const ReportIdle(0));

  final ReportsRepository _repo;
  final bool isMissing;

  int get step => switch (state) {
        ReportIdle(:final step) => step,
        ReportSubmitting(:final step) => step,
        _ => 0,
      };

  bool get submitting => state is ReportSubmitting;

  void next() {
    final current = step;
    if (current < 5) emit(ReportIdle(current + 1));
  }

  void previous() {
    final current = step;
    if (current > 0) emit(ReportIdle(current - 1));
  }

  Future<ChildCase?> submitMissing(MissingReportInput input) async {
    emit(ReportSubmitting(step));
    try {
      final caseData = await _repo.submitMissing(input);
      emit(ReportSubmitted(caseData));
      return caseData;
    } on AppFailure catch (e) {
      emit(ReportError(e));
      return null;
    }
  }

  Future<ChildCase?> submitFound(FoundReportInput input) async {
    emit(ReportSubmitting(step));
    try {
      final caseData = await _repo.submitFound(input);
      emit(ReportSubmitted(caseData));
      return caseData;
    } on AppFailure catch (e) {
      emit(ReportError(e));
      return null;
    }
  }
}
