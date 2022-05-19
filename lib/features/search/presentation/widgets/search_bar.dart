/* 
 * Copyright (C) 2021  Ahmad Rulim
 * 
 * This file is part of Flutter WordPress.
 * 
 * Flutter WordPress is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Flutter WordPress is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Flutter WordPress.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * @license GPL-3.0-or-later <https://spdx.org/licenses/GPL-3.0-or-later.html>
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../providers.dart';

class SearchBar extends ConsumerStatefulWidget {
  final PagingController<String, Post> pagingController;

  const SearchBar({
    required this.pagingController,
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  late final TextEditingController _textFieldController;
  Timer? _timeHandle;

  @override
  void initState() {
    super.initState();

    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _textFieldController.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextField(
      controller: _textFieldController,
      textInputAction: TextInputAction.search,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).searchPlaceholderText,
        contentPadding: const EdgeInsets.all(15),
        suffixIcon: Builder(
          builder: (context) {
            final bool isFilled = ref.watch(searchBarFilledStatusProvider);

            if (isFilled) {
              return IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                ),
                onPressed: () {
                  _textFieldController.clear();
                  ref
                      .read(searchBarFilledStatusProvider.notifier)
                      .setFilledStatus(
                        isFilled: false,
                      );
                  ref.read(searchTermProvider.notifier).setSearchTerm(
                        searchTerm: '',
                      );
                  widget.pagingController.refresh();
                },
              );
            } else {
              return const Icon(
                Icons.search_rounded,
              );
            }
          },
        ),
      ),
      onChanged: (text) {
        ref.read(searchBarFilledStatusProvider.notifier).setFilledStatus(
              isFilled: text.isNotEmpty,
            );

        if (_timeHandle != null) {
          _timeHandle!.cancel();
        }

        _timeHandle = Timer(
          const Duration(milliseconds: 1000),
          () {
            ref.read(searchTermProvider.notifier).setSearchTerm(
                  searchTerm: text,
                );
            widget.pagingController.refresh();
          },
        );
      },
    );
  }
}
