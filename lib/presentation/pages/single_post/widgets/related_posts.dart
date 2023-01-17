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

import '../../../../providers.dart';
import '../../../l10n/generated/l10n.dart';
import '../../../viewmodels/single_post/related_posts_state.dart';
import '../../shared/widgets/error_indicator.dart';
import '../../shared/widgets/post_list_tile.dart';
import '../../shared/widgets/post_list_tile_loading.dart';

class RelatedPosts extends ConsumerStatefulWidget {
  final int postId;
  final List<int> tagsId;

  const RelatedPosts({
    super.key,
    required this.postId,
    required this.tagsId,
  });

  @override
  ConsumerState<RelatedPosts> createState() => _RelatedPostsState();
}

class _RelatedPostsState extends ConsumerState<RelatedPosts> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        ref.read(relatedPostsProvider.notifier).fetchPosts(
              postId: widget.postId.toString(),
              tagsId: widget.tagsId.map((d) => d.toString()).toList(),
            );
      },
    );
  }

  void refresh() {
    ref.read(relatedPostsProvider.notifier).fetchPosts(
          postId: widget.postId.toString(),
          tagsId: widget.tagsId.map((d) => d.toString()).toList(),
        );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).widgetRelatedPostsTitle,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
        Builder(
          builder: (context) {
            final RelatedPostsState state = ref.watch(relatedPostsProvider);

            return state.when(
              loading: () {
                return Column(
                  children: List.generate(
                    3,
                    (index) {
                      return const PostListTileLoading(
                        margin: EdgeInsets.only(top: 15),
                      );
                    },
                  ),
                );
              },
              loaded: (posts) {
                if (posts.isEmpty) {
                  return ErrorIndicator(
                    margin: const EdgeInsets.only(top: 30),
                    message: AppLocalizations.of(context).errorNoPosts,
                    image: 'assets/img/no_data.png',
                    onButtonPressed: () {
                      refresh();
                    },
                  );
                } else {
                  return Column(
                    children: List.generate(
                      posts.length,
                      (index) {
                        return PostListTile(
                          post: posts[index],
                          margin: const EdgeInsets.only(top: 15),
                          onTap: () {
                            context.pop();
                            context.push('/posts/${posts[index].slug}');
                          },
                        );
                      },
                    ),
                  );
                }
              },
              failedToLoadData: () {
                return ErrorIndicator(
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
    );
  }
}
