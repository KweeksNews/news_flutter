// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/content_group_config.dart';
import '../../../../domain/entities/content_group_ids.dart';
import '../../../../infrastructure/dtos/content_group_ids_model.dart';
import '../../../../providers.dart';
import '../../l10n/generated/l10n.dart';
import '../../viewmodels/home/notifier.dart';
import '../shared/error_indicator.dart';
import '../shared/post_box_tile.dart';
import '../shared/post_box_tile_loading.dart';
import '../shared/post_list_tile.dart';
import '../shared/post_list_tile_loading.dart';

class ContentGroup extends ConsumerStatefulWidget {
  final String title;
  final List<ContentGroupConfig> ids;
  final int postsCount;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const ContentGroup({
    super.key,
    required this.title,
    required this.ids,
    required this.postsCount,
    this.margin,
    this.padding,
  });

  @override
  ConsumerState<ContentGroup> createState() => ContentGroupWidgetState();
}

class ContentGroupWidgetState extends ConsumerState<ContentGroup> {
  late Map<String, ContentGroupIds> _itemList;

  @override
  void initState() {
    super.initState();

    _itemList = {
      'all': ContentGroupIdsModel.fromContentGroupConfigList(widget.ids),
    };

    widget.ids.forEach(
      (d) => _itemList[d.id] = ContentGroupIdsModel.fromContentGroupConfigList(
        [d],
      ),
    );

    Future.delayed(
      Duration.zero,
      () {
        ref.read(contentGroupProvider(_itemList['all']!).notifier).fetchPage(
              postsCount: widget.postsCount,
            );
      },
    );
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    ref.read(contentGroupProvider(_itemList['all']!).notifier).fetchPage(
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
                      final ContentGroupIds state = ref.watch(
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
                        onChanged: (ContentGroupIds? value) {
                          ref
                              .read(contentGroupDropdownProvider(
                                      _itemList['all']!)
                                  .notifier)
                              .setIds(
                                ids: value ?? const ContentGroupIds(),
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
              final ContentGroupState state =
                  ref.watch(contentGroupProvider(_itemList['all']!));

              return state.when(
                loading: () {
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
                },
                loaded: (posts) {
                  if (posts.isEmpty) {
                    return ErrorIndicator(
                      margin: const EdgeInsets.only(top: 15),
                      message: AppLocalizations.of(context).errorNoPosts,
                      image: 'assets/img/no_data.png',
                      onButtonPressed: () {
                        refresh(forceRefresh: true);
                      },
                    );
                  } else {
                    return Column(
                      children: List.generate(
                        posts.length,
                        (index) {
                          if (index == 0) {
                            return PostBoxTile(
                              post: posts[index],
                              margin: const EdgeInsets.only(top: 15),
                              onTap: () {
                                context.push('/posts/${posts[index].slug}');
                              },
                            );
                          } else {
                            return PostListTile(
                              post: posts[index],
                              margin: const EdgeInsets.only(top: 15),
                              onTap: () {
                                context.push('/posts/${posts[index].slug}');
                              },
                            );
                          }
                        },
                      ),
                    );
                  }
                },
                failedToLoadData: () {
                  return ErrorIndicator(
                    margin: const EdgeInsets.only(top: 40),
                    message: AppLocalizations.of(context).errorFailedToLoadData,
                    image: 'assets/img/error.png',
                    onButtonPressed: () {
                      refresh();
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
