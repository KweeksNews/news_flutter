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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/post.dart';
import '../providers.dart';
import '../widgets/error_indicator.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/post_box.dart';
import 'single_post.dart';

class SavedPosts extends StatefulWidget {
  const SavedPosts({Key key}) : super(key: key);

  @override
  _SavedPosts createState() => _SavedPosts();
}

class _SavedPosts extends State<SavedPosts> {
  final PagingController _pagingController = PagingController<int, Post>(
    firstPageKey: 0,
  );

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey as int);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final savedPostsDao = context.read(savedPostsDaoProvider);
      final List posts = await savedPostsDao.getSavedPosts(page: pageKey);
      final int totalPosts = await savedPostsDao.countSavedPosts();
      final int fetched = _pagingController.itemList?.length ?? 0;

      if (fetched + posts.length == totalPosts) {
        _pagingController.appendLastPage(posts);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(posts, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Kiriman Tersimpan',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedListView(
            pagingController: _pagingController,
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            builderDelegate: PagedChildBuilderDelegate(
              noItemsFoundIndicatorBuilder: (context) {
                return const ErrorIndicator(
                  message: 'Belum ada kiriman tersimpan.\nMulailah menyimpan!',
                  image: 'assets/no_data.png',
                );
              },
              firstPageProgressIndicatorBuilder: (context) {
                return const LoadingIndicator(
                  count: 5,
                  type: 'post',
                );
              },
              itemBuilder: (context, post, index) {
                final String heroId = '${Random().nextInt(100)}-${post.id}';

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SinglePost(
                          post: post as Post,
                          heroId: heroId,
                        ),
                      ),
                    );
                  },
                  child: PostBox(
                    post: post as Post,
                    heroId: heroId,
                  ),
                );
              },
              firstPageErrorIndicatorBuilder: (context) {
                return ErrorIndicator(
                  message: 'Gagal memuat data.',
                  image: 'assets/error.png',
                  onTryAgain: () {
                    _pagingController.refresh();
                  },
                );
              },
              newPageProgressIndicatorBuilder: (context) {
                return const LoadingIndicator(
                  count: 3,
                  type: 'post',
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                return ErrorIndicator(
                  message: 'Gagal memuat data.',
                  image: 'assets/error.png',
                  onTryAgain: () {
                    _pagingController.retryLastFailedRequest();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
