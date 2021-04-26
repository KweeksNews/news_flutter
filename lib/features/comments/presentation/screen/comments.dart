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

import '../../../../core/entities/comment.dart';
import '../../../../core/widgets/comment_box.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../providers.dart';
import '../notifier/notifier.dart';
import '../widgets/comment_form.dart';

class Comments extends StatefulWidget {
  final int postId;

  const Comments({
    required this.postId,
  });

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final PagingController<int, Comment> _pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read(commentsProvider.notifier).fetchPage(
            widget.postId,
            pageKey,
            _pagingController.itemList?.length ?? 0,
          );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: commentsProvider,
      onChange: (context, state) {
        if (state is CommentsAppend) {
          _pagingController.appendPage(state.comments, state.nextPageKey);
        } else if (state is CommentsAppendLast) {
          _pagingController.appendLastPage(state.comments);
        } else if (state is CommentsError) {
          _pagingController.error = state.message;
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Komentar',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      context.read(commentsProvider.notifier).forceRefresh =
                          true;

                      return Future.sync(
                        () => _pagingController.refresh(),
                      );
                    },
                    child: PagedListView<int, Comment>(
                      pagingController: _pagingController,
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      builderDelegate: PagedChildBuilderDelegate(
                        noItemsFoundIndicatorBuilder: (context) {
                          return const ErrorIndicator(
                            message:
                                'Belum ada komentar.\nJadilah yang pertama!',
                            image: 'assets/no_data.png',
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) {
                          return const LoadingIndicator(
                            count: 5,
                            type: 'comment',
                          );
                        },
                        itemBuilder: (context, comment, index) {
                          return CommentBox(comment: comment);
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
                            type: 'comment',
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
                CommentForm(
                  postId: widget.postId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
