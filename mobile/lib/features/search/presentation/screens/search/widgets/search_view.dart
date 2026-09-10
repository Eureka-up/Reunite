import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../search_cubit.dart';
import 'search_body.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SearchCubit>();
    final state = cubit.state;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDimens.xl, AppDimens.lg, AppDimens.xl, AppDimens.md),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  Expanded(
                    child: AppSearchBar(
                      controller: _controller,
                      autofocus: true,
                      hint: context.tr('search.hint'),
                      onChanged: cubit.search,
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SearchBody(state: state),
            ),
          ],
        ),
      ),
    );
  }
}
