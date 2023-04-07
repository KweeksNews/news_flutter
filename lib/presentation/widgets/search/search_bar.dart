// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../domain/entities/post.dart';
import '../../../../providers.dart';
import '../../l10n/generated/l10n.dart';

class SearchBar extends ConsumerStatefulWidget {
  final PagingController<String, Post> pagingController;

  const SearchBar({
    super.key,
    required this.pagingController,
  });

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
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
