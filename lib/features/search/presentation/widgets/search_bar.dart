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

import '../../../../providers.dart';

class SearchBar extends StatefulWidget {
  final PagingController pagingController;

  const SearchBar({
    required this.pagingController,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textFieldController = TextEditingController();
  Timer? _timeHandle;

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardTheme.shadowColor!,
              blurRadius: 5,
            )
          ],
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.search,
              style: Theme.of(context).primaryTextTheme.headline4,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Masukkan kata kunci',
                hintStyle: Theme.of(context).primaryTextTheme.headline4,
                suffixIcon: Consumer(
                  builder: (context, watch, child) {
                    final bool status = watch(searchFieldProvider);

                    if (status) {
                      return Icon(
                        Icons.search_rounded,
                        color: Theme.of(context).primaryColor,
                      );
                    } else {
                      return IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _textFieldController.clear();
                          context
                              .read(searchFieldProvider.notifier)
                              .setState(true);
                          context.read(searchProvider.notifier).searchTerm = '';
                          widget.pagingController.refresh();
                        },
                      );
                    }
                  },
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (text) {
                context.read(searchFieldProvider.notifier).setState(text == '');

                if (_timeHandle != null) {
                  _timeHandle!.cancel();
                }

                _timeHandle = Timer(
                  const Duration(milliseconds: 1000),
                  () {
                    context.read(searchProvider.notifier).searchTerm = text;
                    widget.pagingController.refresh();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
