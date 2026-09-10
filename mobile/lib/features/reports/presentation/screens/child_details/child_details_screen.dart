import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../data/repositories/child_case_repository.dart';
import '../../details_cubit.dart';
import 'widgets/details_view.dart';

@RoutePage()
class ChildDetailsScreen extends StatelessWidget {
  const ChildDetailsScreen({super.key, required this.caseId});
  final String caseId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit(getIt<ChildCaseRepository>(), caseId: caseId),
      child: const ModernDetailsView(),
    );
  }
}
