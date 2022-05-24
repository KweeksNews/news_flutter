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

import '../../../../core/entities/state_exception.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/types/state_exception_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/post_list_tile.dart';
import '../../../../core/widgets/post_list_tile_loading.dart';
import '../../../../providers.dart';
import '../notifier/related_posts_state.dart';

class RelatedPosts extends ConsumerStatefulWidget {
  final int postId;
  final List<int> tagsId;

  const RelatedPosts({
    required this.postId,
    required this.tagsId,
    Key? key,
  }) : super(key: key);

  @override
  _RelatedPostsState createState() => _RelatedPostsState();
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

            if (state is RelatedPostsLoading) {
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
            } else if (state is RelatedPostsLoaded) {
              return Column(
                children: List.generate(state.posts.length, (index) {
                  return PostListTile(
                    post: state.posts[index],
                    margin: const EdgeInsets.only(top: 15),
                    onTap: () {
                      context.pop();
                      context.push('/posts/${state.posts[index].slug}');
                    },
                  );
                }),
              );
            } else if (state is RelatedPostsException) {
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
    );
  }
}
