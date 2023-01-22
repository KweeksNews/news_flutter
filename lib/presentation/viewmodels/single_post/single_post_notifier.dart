// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/single_post/get_post.dart';
import '../../../domain/entities/post_id.dart';
import 'notifier.dart';

@injectable
class SinglePostNotifier extends StateNotifier<SinglePostState> {
  final GetPost _getPost;

  SinglePostNotifier(
    this._getPost,
  ) : super(const SinglePostState.loading());

  Future<void> fetchPost({
    required PostId id,
  }) async {
    state = const SinglePostState.loading();

    final failureOrPost = await _getPost(
      id: id,
      forceRefresh: true,
    );

    if (mounted) {
      failureOrPost.fold(
        (failure) {
          state = const SinglePostState.failedToLoadData();
        },
        (postData) {
          state = SinglePostState.loaded(
            post: postData,
          );
        },
      );
    }
  }
}
