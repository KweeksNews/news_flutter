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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/config/route.dart';
import '../../../../core/entities/post.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/router/route_action.dart';
import '../../../../core/router/route_config.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/post_box.dart';
import '../../../../providers.dart';
import '../notifier/notifier.dart';

class ContentsTab extends ConsumerStatefulWidget {
  final String categoryId;

  const ContentsTab({
    required this.categoryId,
    Key? key,
  }) : super(key: key);

  @override
  _ContentsTabState createState() => _ContentsTabState();
}

class _ContentsTabState extends ConsumerState<ContentsTab> {
  final PagingController<String, Post> _pagingController = PagingController(
    firstPageKey: '',
  );

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(
      (pageKey) {
        ref.read(homeProvider(widget.categoryId).notifier).fetchPage(
              pageKey,
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
  Widget build(BuildContext context) {
    ref.listen(
      homeProvider(widget.categoryId),
      (context, state) {
        if (state is HomeAppend) {
          _pagingController.appendPage(state.posts, state.nextPageKey);
        } else if (state is HomeAppendLast) {
          _pagingController.appendLastPage(state.posts);
        } else if (state is HomeError) {
          _pagingController.error = state;
        }
      },
    );

    return RefreshIndicator(
      onRefresh: () {
        ref.read(homeProvider(widget.categoryId).notifier).forceRefresh = true;

        return Future.sync(
          () => _pagingController.refresh(),
        );
      },
      child: PagedListView<String, Post>(
        pagingController: _pagingController,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: (context) {
            return ErrorIndicator(
              message: AppLocalizations.of(context).errorNoPosts,
              image: 'assets/img/no_data.png',
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return const LoadingIndicator(
              count: 5,
              type: LoadingType.post,
            );
          },
          itemBuilder: (context, post, index) {
            return InkWell(
              onTap: () {
                ref.read(routeStateProvider).setCurrentRootAction(
                      RouteAction(
                        state: RouteActionState.push,
                        page: ROUTE.config['singlePost']!.copyWith(
                          path: '/posts/${post.slug}',
                          parameters: {
                            'slug': post.slug,
                          },
                        ),
                      ),
                    );
              },
              child: PostBox(
                post: post,
              ),
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
            return const LoadingIndicator(
              count: 3,
              type: LoadingType.post,
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
    );
  }
}