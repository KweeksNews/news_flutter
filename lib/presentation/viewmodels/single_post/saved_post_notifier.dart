// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/single_post/add_saved_post.dart';
import '../../../application/single_post/check_post_save_status.dart';
import '../../../application/single_post/delete_saved_post.dart';
import '../../../domain/entities/post.dart';
import '../../pages/saved_posts/saved_posts_page.dart';

@injectable
class SavedPostNotifier extends StateNotifier<bool> {
  final AddSavedPost _createSavedPost;
  final DeleteSavedPost _deleteSavedPost;
  final CheckPostSaveStatus _checkPostSaveStatus;
  final GlobalKey<SavedPostsPageState> _savedPostsPageKey;
  bool forceRefresh = true;

  SavedPostNotifier(
    this._createSavedPost,
    this._deleteSavedPost,
    this._checkPostSaveStatus,
    @Named('savedPostsPageKey') this._savedPostsPageKey,
  ) : super(false);

  Future<void> createPost({
    required Post post,
  }) async {
    final failureOrStatus = await _createSavedPost(
      post: post,
    );

    if (mounted) {
      failureOrStatus.fold(
        (failure) {
          state = false;
        },
        (status) {
          state = true;

          _savedPostsPageKey.currentState?.refresh();
        },
      );
    }
  }

  Future<void> deletePost({
    required int postId,
  }) async {
    final failureOrStatus = await _deleteSavedPost(
      postId: postId,
    );

    if (mounted) {
      failureOrStatus.fold(
        (failure) {
          state = true;
        },
        (status) {
          state = false;

          _savedPostsPageKey.currentState?.refresh();
        },
      );
    }
  }

  Future<void> checkPostSaveStatus({
    required int postId,
  }) async {
    final failureOrStatus = await _checkPostSaveStatus(
      postId: postId,
    );

    if (mounted) {
      failureOrStatus.fold(
        (failure) {
          state = false;
        },
        (status) {
          state = status;
        },
      );
    }
  }
}
