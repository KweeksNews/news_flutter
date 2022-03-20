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
import 'package:nil/nil.dart';

import '../../../../core/config/route.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/router/route_action.dart';
import '../../../../core/router/route_config.dart';
import '../../../../core/types/loading_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/post_tile.dart';
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
      () => ref.read(relatedPostsProvider.notifier).fetchPosts(
            widget.postId.toString(),
            widget.tagsId.map((d) => d.toString()).toList(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              AppLocalizations.of(context).widgetRelatedPostsTitle,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.left,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final RelatedPostsState state = ref.watch(relatedPostsProvider);

              if (state is RelatedPostsLoading) {
                return const LoadingIndicator(
                  count: 3,
                  type: LoadingType.postTile,
                );
              } else if (state is RelatedPostsLoaded) {
                return Column(
                  children: List.generate(state.posts.length, (index) {
                    return InkWell(
                      onTap: () {
                        ref.read(routeStateProvider).setCurrentRootAction(
                              RouteAction(
                                state: RouteActionState.pushReplacement,
                                page: ROUTE.config['singlePost']!.copyWith(
                                  path: '/posts/${state.posts[index].slug}',
                                  parameters: {
                                    'slug': state.posts[index].slug,
                                  },
                                ),
                              ),
                            );
                      },
                      child: PostTile(
                        post: state.posts[index],
                      ),
                    );
                  }),
                );
              } else if (state is RelatedPostsError) {
                return ErrorIndicator(
                  message: state.message,
                  image: 'assets/img/error.png',
                  onTryAgain: () {
                    ref.read(relatedPostsProvider.notifier).fetchPosts(
                          widget.postId.toString(),
                          widget.tagsId.map((d) => d.toString()).toList(),
                        );
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
