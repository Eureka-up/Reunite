import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/context_extensions.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../notifications_cubit.dart';
import 'widgets/notification_states.dart';
import 'widgets/notifications_list.dart';

@RoutePage()
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.background,
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<NotificationsCubit, NotificationsState>(
          listener: (context, state) {
            if (state is NotificationsError) {
              showAppSnackbar(context, text: context.tr(state.failure.messageKey), type: SnackBarType.error);
            }
          },
          builder: (context, state) {
            return switch (state) {
              NotificationsLoading() => const ModernSkeleton(),
              NotificationsError() => ErrorState(message: context.tr('errors.title'), onRetry: () => context.read<NotificationsCubit>().load()),
              NotificationsLoaded(:final items) => items.isEmpty ? const VeryModernEmpty() : NotificationsList(items: items),
            };
          },
        ),
      ),
    );
  }
}
