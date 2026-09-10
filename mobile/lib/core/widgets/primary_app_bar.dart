import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';

/// App title bar used on inner screens with adaptive colors.
class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.leading,
    this.backgroundColor,
    this.elevated = true,
  });

  final String title;
  final List<Widget> actions;
  final Widget? leading;
  final Color? backgroundColor;
  final bool elevated;

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.giant);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leading == null,
      leading: leading,
      title: Text(title, style: context.textTheme.titleLarge),
      actions: actions,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: elevated ? 1 : 0,
    );
  }
}