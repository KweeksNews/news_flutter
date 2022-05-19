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

import '../../../../core/config/config.dart';
import '../../../../core/entities/post.dart';
import '../../../../core/entities/state_exception.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/types/state_exception_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/post_list_tile.dart';
import '../../../../core/widgets/post_list_tile_loading.dart';
import '../../../../providers.dart';
import '../notifier/notifier.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_category_box_tile.dart';

class Search extends ConsumerStatefulWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search>
    with AutomaticKeepAliveClientMixin<Search> {
  late final PagingController<String, Post> _pagingController;
  bool _forceRefresh = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(
      firstPageKey: '',
    );

    _pagingController.addPageRequestListener(
      (pageKey) {
        ref.read(searchProvider.notifier).fetchPage(
              pageKey: pageKey,
              forceRefresh: _forceRefresh,
            );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    _forceRefresh = forceRefresh;

    _pagingController.refresh();

    if (forceRefresh) {
      _forceRefresh = false;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);

    ref.listen<SearchState>(
      searchProvider,
      (previousState, newState) {
        if (newState is SearchAppend) {
          _pagingController.appendPage(newState.posts, newState.nextPageKey);
        } else if (newState is SearchAppendLast) {
          _pagingController.appendLastPage(newState.posts);
        } else if (newState is SearchException) {
          if (newState.type == StateExceptionType.noSearchTerm) {
            _pagingController.error = StateException(
              message: AppLocalizations.of(context).errorNoSearchTerm,
              image: 'assets/img/search.png',
            );
          } else if (newState.type == StateExceptionType.failedToLoadData) {
            _pagingController.error = StateException(
              message: AppLocalizations.of(context).errorFailedToLoadData,
              image: 'assets/img/error.png',
            );
          } else {
            _pagingController.error = StateException(
              message: AppLocalizations.of(context).errorGeneric,
              image: 'assets/img/error.png',
            );
          }
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
              pinned: true,
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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(84),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SearchBar(
                    pagingController: _pagingController,
                  ),
                ),
              ),
            ),
          ],
          body: Builder(builder: (context) {
            final String searchTerm = ref.watch(searchTermProvider);

            if (searchTerm.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => refresh(forceRefresh: true),
                ),
                child: PagedListView<String, Post>(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    noItemsFoundIndicatorBuilder: (context) {
                      return ErrorIndicator(
                        message:
                            AppLocalizations.of(context).errorNoSearchResults,
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
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: CONFIG.searchCategory.length,
                itemBuilder: (context, index) {
                  return SearchCategoryBoxTile(
                    category: CONFIG.searchCategory[index],
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
