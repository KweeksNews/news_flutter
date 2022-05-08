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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nil/nil.dart';

import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/types/content_group_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/post_box_tile.dart';
import '../../../../core/widgets/post_box_tile_loading.dart';
import '../../../../core/widgets/post_list_tile.dart';
import '../../../../core/widgets/post_list_tile_loading.dart';
import '../../../../providers.dart';
import '../../domain/entities/content_group_config.dart';
import '../notifier/notifier.dart';

class ContentGroup extends ConsumerStatefulWidget {
  final String title;
  final ContentGroupType type;
  final List<ContentGroupConfig> ids;
  final int postsCount;

  const ContentGroup({
    required this.title,
    required this.type,
    required this.ids,
    required this.postsCount,
    Key? key,
  }) : super(key: key);

  @override
  ContentGroupState createState() => ContentGroupState();
}

class ContentGroupState extends ConsumerState<ContentGroup> {
  late List<Map<String, Object>> _itemList;
  List<String>? _categoryIds;
  List<String>? _tagIds;

  @override
  void initState() {
    super.initState();

    _itemList = [
      {
        'name': AppLocalizations.current.optionContentGroupDropdownAll,
        'ids': List<String>.from(widget.ids.map((d) => d.id)),
      },
      ...widget.ids.map(
        (d) => {
          'name': d.name,
          'ids': [d.id]
        },
      )
    ];

    if (widget.type == ContentGroupType.category) {
      _categoryIds = _itemList[0]['ids'] as List<String>;
    } else if (widget.type == ContentGroupType.tag) {
      _tagIds = _itemList[0]['ids'] as List<String>;
    }

    Future.delayed(
      Duration.zero,
      () => ref.read(contentGroupProvider(widget.title).notifier).fetchPage(
            categoryIds: _categoryIds,
            tagIds: _tagIds,
            postsCount: widget.postsCount,
          ),
    );
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    ref.read(contentGroupProvider(widget.title).notifier).fetchPage(
          categoryIds: _categoryIds,
          tagIds: _tagIds,
          postsCount: widget.postsCount,
          forceRefresh: forceRefresh,
        );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Expanded(
                flex: 1,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isDense: true,
                    isExpanded: true,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    value: widget.type == ContentGroupType.category
                        ? _categoryIds
                        : _tagIds,
                    icon: const FaIcon(
                      FontAwesomeIcons.chevronCircleDown,
                    ),
                    iconSize: 20,
                    items: [
                      ..._itemList.map(
                        (d) => DropdownMenuItem(
                          child: Text(
                            d['name'] as String,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: d['ids'] as List<String>,
                        ),
                      )
                    ],
                    onChanged: (List<String>? value) {
                      setState(() {
                        if (widget.type == ContentGroupType.category) {
                          _categoryIds = value!;
                        } else if (widget.type == ContentGroupType.tag) {
                          _tagIds = value!;
                        }
                      });
                      refresh();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final HomeState state =
                ref.watch(contentGroupProvider(widget.title));

            if (state is HomeLoading) {
              return Column(
                children: List.generate(
                  widget.postsCount,
                  (index) {
                    if (index == 0) {
                      return const PostBoxTileLoading(
                        margin: EdgeInsets.only(bottom: 15),
                      );
                    } else {
                      return PostListTileLoading(
                        margin: index != widget.postsCount
                            ? const EdgeInsets.only(bottom: 15)
                            : null,
                      );
                    }
                  },
                ),
              );
            } else if (state is HomeLoaded) {
              if (state.posts.isEmpty) {
                return ErrorIndicator(
                  message: AppLocalizations.of(context).errorNoPosts,
                  image: 'assets/img/no_data.png',
                  onTryAgain: () {
                    refresh(forceRefresh: true);
                  },
                );
              } else {
                return Column(
                  children: List.generate(
                    state.posts.length,
                    (index) {
                      if (index == 0) {
                        return PostBoxTile(
                          post: state.posts[index],
                          margin: index != state.posts.length - 1
                              ? const EdgeInsets.only(bottom: 15)
                              : null,
                          onTap: () {
                            context.push('/posts/${state.posts[index].slug}');
                          },
                        );
                      } else {
                        return PostListTile(
                          post: state.posts[index],
                          margin: index != state.posts.length - 1
                              ? const EdgeInsets.only(bottom: 15)
                              : null,
                          onTap: () {
                            context.push('/posts/${state.posts[index].slug}');
                          },
                        );
                      }
                    },
                  ),
                );
              }
            } else if (state is HomeError) {
              return ErrorIndicator(
                message: state.message,
                image: 'assets/img/error.png',
                onTryAgain: () {
                  refresh();
                },
              );
            } else {
              return const Nil();
            }
          },
        ),
      ],
    );
  }
}