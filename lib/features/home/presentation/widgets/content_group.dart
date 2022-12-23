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
import 'package:go_router/go_router.dart';
import 'package:nil/nil.dart';

import '../../../../core/domain/entities/state_exception.dart';
import '../../../../core/domain/enums/content_group_type.dart';
import '../../../../core/domain/enums/state_exception_type.dart';
import '../../../../core/presentation/l10n/generated/l10n.dart';
import '../../../../core/presentation/widgets/error_indicator.dart';
import '../../../../core/presentation/widgets/post_box_tile.dart';
import '../../../../core/presentation/widgets/post_box_tile_loading.dart';
import '../../../../core/presentation/widgets/post_list_tile.dart';
import '../../../../core/presentation/widgets/post_list_tile_loading.dart';
import '../../../../providers.dart';
import '../../domain/entities/content_group_config.dart';
import '../notifier/notifier.dart';

class ContentGroup extends ConsumerStatefulWidget {
  final String title;
  final ContentGroupType type;
  final List<ContentGroupConfig> ids;
  final int postsCount;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const ContentGroup({
    super.key,
    required this.title,
    required this.type,
    required this.ids,
    required this.postsCount,
    this.margin,
    this.padding,
  });

  @override
  ConsumerState<ContentGroup> createState() => ContentGroupState();
}

class ContentGroupState extends ConsumerState<ContentGroup> {
  late Map<String, List<String>> _itemList;

  @override
  void initState() {
    super.initState();

    _itemList = {
      'all': List<String>.from(widget.ids.map((d) => d.id)),
    };

    widget.ids.forEach(
      (d) => _itemList[d.id] = [d.id],
    );

    Future.delayed(
      Duration.zero,
      () {
        ref.read(contentGroupProvider(_itemList['all']!).notifier).fetchPage(
              contentGroupType: widget.type,
              postsCount: widget.postsCount,
            );
      },
    );
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    ref.read(contentGroupProvider(_itemList['all']!).notifier).fetchPage(
          contentGroupType: widget.type,
          postsCount: widget.postsCount,
          forceRefresh: forceRefresh,
        );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      child: Column(
        children: <Widget>[
          Row(
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
                  child: Builder(
                    builder: (context) {
                      final List<String> state = ref.watch(
                        contentGroupDropdownProvider(_itemList['all']!),
                      );

                      return DropdownButton(
                        isDense: true,
                        isExpanded: true,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        value: state,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                        // iconSize: 20,
                        items: [
                          DropdownMenuItem(
                            value: _itemList['all'],
                            child: Text(
                              AppLocalizations.of(context)
                                  .optionContentGroupDropdownAll,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ...widget.ids.map(
                            (d) => DropdownMenuItem(
                              value: _itemList[d.id],
                              child: Text(
                                d.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                        onChanged: (List<String>? value) {
                          ref
                              .read(
                                contentGroupDropdownProvider(_itemList['all']!)
                                    .notifier,
                              )
                              .setIds(
                                ids: value,
                              );
                          refresh();
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          Builder(
            builder: (context) {
              final HomeState state =
                  ref.watch(contentGroupProvider(_itemList['all']!));

              if (state is HomeLoading) {
                return Column(
                  children: List.generate(
                    widget.postsCount,
                    (index) {
                      if (index == 0) {
                        return const PostBoxTileLoading(
                          margin: EdgeInsets.only(top: 15),
                        );
                      } else {
                        return PostListTileLoading(
                          margin: index != widget.postsCount
                              ? const EdgeInsets.only(top: 15)
                              : null,
                        );
                      }
                    },
                  ),
                );
              } else if (state is HomeLoaded) {
                if (state.posts.isEmpty) {
                  return ErrorIndicator(
                    margin: const EdgeInsets.only(top: 15),
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
                            margin: const EdgeInsets.only(top: 15),
                            onTap: () {
                              context.push('/posts/${state.posts[index].slug}');
                            },
                          );
                        } else {
                          return PostListTile(
                            post: state.posts[index],
                            margin: const EdgeInsets.only(top: 15),
                            onTap: () {
                              context.push('/posts/${state.posts[index].slug}');
                            },
                          );
                        }
                      },
                    ),
                  );
                }
              } else if (state is HomeException) {
                late StateException exception;

                if (state.type == StateExceptionType.failedToLoadData) {
                  exception = StateException(
                    message: AppLocalizations.of(context).errorFailedToLoadData,
                    image: 'assets/img/error.png',
                  );
                } else {
                  exception = StateException(
                    message: AppLocalizations.of(context).errorGeneric,
                    image: 'assets/img/error.png',
                  );
                }

                return ErrorIndicator(
                  margin: const EdgeInsets.only(top: 40),
                  message: exception.message,
                  image: exception.image,
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
      ),
    );
  }
}
