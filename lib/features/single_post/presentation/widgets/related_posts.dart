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

import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/post_box.dart';
import '../../../../providers.dart';
import '../notifier/related_posts_state.dart';
import '../pages/single_post.dart';

class RelatedPosts extends StatefulWidget {
  final int postId;
  final int catId;

  const RelatedPosts({
    required this.postId,
    required this.catId,
  });

  @override
  _RelatedPostsState createState() => _RelatedPostsState();
}

class _RelatedPostsState extends State<RelatedPosts> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => context.read(relatedPostsProvider.notifier).fetchPosts(
            widget.postId,
            widget.catId,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              'Kiriman Terkait',
              style: Theme.of(context).primaryTextTheme.headline1,
              textAlign: TextAlign.left,
            ),
          ),
          Consumer(
            builder: (context, watch, child) {
              final RelatedPostsState state = watch(relatedPostsProvider);

              if (state is RelatedPostsLoading) {
                return const LoadingIndicator(
                  count: 3,
                  type: LoadingType.post,
                );
              } else if (state is RelatedPostsLoaded) {
                return Column(
                  children: List.generate(state.posts.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SinglePost(
                              post: state.posts[index],
                            ),
                          ),
                        );
                      },
                      child: PostBox(
                        post: state.posts[index],
                      ),
                    );
                  }),
                );
              } else {
                return ErrorIndicator(
                  message: 'Gagal memuat data.',
                  image: 'assets/error.png',
                  onTryAgain: () {
                    context.read(relatedPostsProvider.notifier).fetchPosts(
                          widget.postId,
                          widget.catId,
                        );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
