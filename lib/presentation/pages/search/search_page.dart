// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../config/config.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/entities/state_exception.dart';
import '../../../providers.dart';
import '../../l10n/generated/l10n.dart';
import '../../viewmodels/search/notifier.dart';
import '../../widgets/search/search_bar.dart';
import '../../widgets/search/search_category_box_tile.dart';
import '../../widgets/shared/error_indicator.dart';
import '../../widgets/shared/post_list_tile.dart';
import '../../widgets/shared/post_list_tile_loading.dart';

class Search extends ConsumerStatefulWidget {
  const Search({
    super.key,
  });

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  late final PagingController<String, Post> _pagingController;
  bool _forceRefresh = false;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(
      firstPageKey: '',
    );

    _pagingController.addPageRequestListener(
      (pageKey) {
        ref.read(searchProvider.notifier).fetchPage(
              postsCount: 10,
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
    ref.listen<SearchState>(
      searchProvider,
      (previousState, newState) {
        newState.whenOrNull(
          noSearchTerm: () {
            _pagingController.error = StateException(
              message: AppLocalizations.of(context).errorNoSearchTerm,
              image: 'assets/img/search.png',
            );
          },
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
                  padding: const EdgeInsets.only(left: 15, right: 15),
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
