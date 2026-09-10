import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../data/repositories/child_case_repository.dart';
import '../../report_cubit.dart';
import 'widgets/found_view.dart';

@RoutePage()
class ReportFoundScreen extends StatelessWidget {
  const ReportFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportCubit(getIt<ReportsRepository>(), isMissing: false),
      child: const ModernFoundView(),
    );
  }
}
