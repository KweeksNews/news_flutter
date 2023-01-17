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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../domain/entities/post.dart';
import '../../../../domain/entities/state_exception.dart';
import '../../../../providers.dart';
import '../../../l10n/generated/l10n.dart';
import '../../../viewmodels/single_category/notifier.dart';
import '../../shared/widgets/error_indicator.dart';
import '../../shared/widgets/post_list_tile.dart';
import '../../shared/widgets/post_list_tile_loading.dart';

class CategoryPosts extends ConsumerStatefulWidget {
  final int id;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CategoryPosts({
    super.key,
    required this.id,
    this.margin,
    this.padding,
  });

  @override
  ConsumerState<CategoryPosts> createState() => _CategoryPostsState();
}

class _CategoryPostsState extends ConsumerState<CategoryPosts> {
  late final PagingController<String, Post> _pagingController;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(
      firstPageKey: '',
    );

    _pagingController.addPageRequestListener(
      (pageKey) {
        ref.read(categoryPostsProvider.notifier).fetchPage(
          categoryIn: [widget.id.toString()],
          pageKey: pageKey,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ref.listen<CategoryPostsState>(
      categoryPostsProvider,
      (previousState, newState) {
        newState.whenOrNull(
          appendPage: (posts, nextPageKey) {
            _pagingController.appendPage(posts, nextPageKey);
          },
          appendLastPage: (posts) {
            _pagingController.appendLastPage(posts);
          },
          failedToLoadData: () {
            _pagingController.error = StateException(
              message: AppLocalizations.of(context).errorFailedToLoadData,
              image: 'assets/img/error.png',
            );
          },
        );
      },
    );

    return Container(
      margin: widget.margin,
      child: PagedListView<String, Post>(
        shrinkWrap: true,
        padding: widget.padding,
        physics: const NeverScrollableScrollPhysics(),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: (context) {
            return ErrorIndicator(
              message: AppLocalizations.of(context).errorNoPosts,
              image: 'assets/img/no_data.png',
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return Column(
              children: List.generate(
                5,
                (index) {
                  return const PostListTileLoading(
                    margin: EdgeInsets.only(top: 15),
                  );
                },
              ),
            );
          },
          itemBuilder: (context, post, index) {
            return PostListTile(
              post: post,
              margin: const EdgeInsets.only(top: 15),
              onTap: () {
                context.push('/posts/${post.slug}');
              },
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return ErrorIndicator(
              message: _pagingController.error.message as String,
              image: _pagingController.error.image as String,
              onButtonPressed: () {
                _pagingController.refresh();
              },
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return Column(
              children: List.generate(
                5,
                (index) {
                  return const PostListTileLoading(
                    margin: EdgeInsets.only(top: 15),
                  );
                },
              ),
            );
          },
          newPageErrorIndicatorBuilder: (context) {
            return ErrorIndicator(
              margin: const EdgeInsets.only(top: 15),
              message: _pagingController.error.message as String,
              image: _pagingController.error.image as String,
              onButtonPressed: () {
                _pagingController.retryLastFailedRequest();
              },
            );
          },
        ),
      ),
    );
  }
}
