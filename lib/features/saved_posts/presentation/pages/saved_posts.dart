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

import '../../../../core/entities/post.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/post_list_tile.dart';
import '../../../../core/widgets/post_list_tile_loading.dart';
import '../../../../providers.dart';
import '../notifier/notifier.dart';

class SavedPosts extends ConsumerStatefulWidget {
  const SavedPosts({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _SavedPosts createState() => _SavedPosts();
}

class _SavedPosts extends ConsumerState<SavedPosts>
    with AutomaticKeepAliveClientMixin<SavedPosts> {
  final PagingController<int, Post> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(
      (pageKey) {
        ref.read(savedPostsProvider.notifier).fetchPage(
              pageKey,
              _pagingController.itemList?.length ?? 0,
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
    super.build(context);

    ref.listen(
      savedPostsProvider,
      (context, state) {
        if (state is SavedPostsAppend) {
          _pagingController.appendPage(state.posts, state.nextPageKey);
        } else if (state is SavedPostsAppendLast) {
          _pagingController.appendLastPage(state.posts);
        } else if (state is SavedPostsException) {
          _pagingController.error = state;
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              centerTitle: true,
              elevation: 0,
              title: Text(
                AppLocalizations.of(context).pageSavedPostsTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
              () {
                ref.read(savedPostsProvider.notifier).forceRefresh = true;

                _pagingController.refresh();
              },
            ),
            child: PagedListView<int, Post>(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                noItemsFoundIndicatorBuilder: (context) {
                  return ErrorIndicator(
                    message: AppLocalizations.of(context).errorNoSavedPosts,
                    image: 'assets/img/no_data.png',
                  );
                },
                firstPageProgressIndicatorBuilder: (context) {
                  return Column(
                    children: List.generate(
                      5,
                      (index) {
                        return const PostListTileLoading(
                          margin: EdgeInsets.only(bottom: 15),
                        );
                      },
                    ),
                  );
                },
                itemBuilder: (context, post, index) {
                  return PostListTile(
                    post: post,
                    margin: const EdgeInsets.only(bottom: 15),
                    onTap: () {
                      context.push('/posts/${post.slug}');
                    },
                  );
                },
                firstPageErrorIndicatorBuilder: (context) {
                  return ErrorIndicator(
                    message: _pagingController.error.message as String,
                    image: _pagingController.error.image as String,
                    onTryAgain: () {
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
                          margin: EdgeInsets.only(bottom: 15),
                        );
                      },
                    ),
                  );
                },
                newPageErrorIndicatorBuilder: (context) {
                  return ErrorIndicator(
                    message: _pagingController.error.message as String,
                    image: _pagingController.error.image as String,
                    onTryAgain: () {
                      _pagingController.retryLastFailedRequest();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
