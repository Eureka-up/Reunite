import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/theme/app_dimens.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../reports/data/repositories/child_case_repository.dart';
import '../../../../reports/domain/child_case.dart';
import '../../../../reports/presentation/my_reports_cubit.dart';
import 'widgets/report_card.dart';

@RoutePage()
class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyReportsCubit(getIt<ReportsRepository>()),
      child: const MyReportsView(),
    );
  }
}

class MyReportsView extends StatefulWidget {
  const MyReportsView({super.key});

  @override
  State<MyReportsView> createState() => MyReportsViewState();
}

class MyReportsViewState extends State<MyReportsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 4, vsync: this);

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select<MyReportsCubit, MyReportsState>(
        (c) => c.state);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('myReports.title'),
            style: context.textTheme.titleLarge),
      ),
      body: switch (state) {
        MyReportsLoading() => const Center(child: CircularProgressIndicator()),
        MyReportsError() => ErrorState(
            message: context.tr('errors.title'),
            onRetry: () => context.read<MyReportsCubit>().load(),
          ),
        MyReportsLoaded() => _buildTabs(state),
      },
    );
  }

  Widget _buildTabs(MyReportsLoaded loaded) {
    final tabs = [
      (context.tr('myReports.active'), loaded.active),
      (context.tr('myReports.pending'), loaded.pending),
      (context.tr('myReports.found'), loaded.found),
      (context.tr('myReports.closed'), loaded.closed),
    ];
    return Column(
      children: [
        TabBar(
          controller: _tab,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [for (final (label, list) in tabs) Tab(text: '$label (${list.length})')],
        ),
        Expanded(
          child: TabBarView(
            controller: _tab,
            children: [
              for (final (_, list) in tabs)
                list.isEmpty
                    ? EmptyState(
                        title: context.tr('myReports.noReports'),
                        subtitle: context.tr('myReports.noReportsSub'),
                        icon: Icons.description_outlined,
                      )
                    : ListView(
                        padding: const EdgeInsets.all(AppDimens.xl),
                        children: [
                          for (final ChildCase report in list)
                            ReportCard(report: report),
                        ],
                      ),
            ],
          ),
        ),
      ],
    );
  }
}
