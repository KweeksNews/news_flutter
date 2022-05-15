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
import '../widgets/search_bar.dart';

class Search extends ConsumerStatefulWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final PagingController<String, Post> _pagingController = PagingController(
    firstPageKey: '',
  );

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(
      (pageKey) {
        ref.read(searchProvider.notifier).fetchPage(pageKey);
      },
    );

    _pagingController.error = SearchError(
      message: AppLocalizations.current.errorNoSearchTerm,
      image: 'assets/img/search.png',
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
      searchProvider,
      (context, state) {
        if (state is SearchAppend) {
          _pagingController.appendPage(state.posts, state.nextPageKey);
        } else if (state is SearchAppendLast) {
          _pagingController.appendLastPage(state.posts);
        } else if (state is SearchError) {
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
                AppLocalizations.of(context).pageSearchTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SearchBar(
                  pagingController: _pagingController,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    ref.read(searchProvider.notifier).forceRefresh = true;

                    return Future.sync(
                      () => _pagingController.refresh(),
                    );
                  },
                  child: PagedListView<String, Post>(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      noItemsFoundIndicatorBuilder: (context) {
                        return ErrorIndicator(
                          message:
                              AppLocalizations.of(context).errorNoSearchResult,
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
            ],
          ),
        ),
      ),
    );
  }
}
