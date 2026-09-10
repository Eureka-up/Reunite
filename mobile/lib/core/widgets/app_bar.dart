import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';

/// Standard back app bar for inner screens.
class AppBackBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackBar({
    super.key,
    this.title,
    this.actions = const [],
    this.trailing,
  });

  final String? title;
  final List<Widget> actions;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.giant);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title == null ? null : Text(title!, style: context.textTheme.titleLarge),
      centerTitle: true,
      actions: actions,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    );
  }
}