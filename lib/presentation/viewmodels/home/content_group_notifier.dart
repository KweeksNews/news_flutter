// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/enums/content_group_type.dart';
import '../../../../providers.dart';
import '../../../application/shared/get_posts.dart';
import 'notifier.dart';

@injectable
class ContentGroupNotifier extends StateNotifier<ContentGroupState> {
  final GetPosts _getPosts;
  final List<String> _initialIds;
  final Ref _ref;

  ContentGroupNotifier(
    this._getPosts,
    @factoryParam this._initialIds,
    @factoryParam this._ref,
  ) : super(const ContentGroupState.loading());

  Future<void> fetchPage({
    required ContentGroupType contentGroupType,
    required int postsCount,
    bool forceRefresh = false,
  }) async {
    state = const ContentGroupState.loading();

    final id = _ref.read(contentGroupDropdownProvider(_initialIds));

    final failureOrPosts = await _getPosts(
      categoryIn: contentGroupType == ContentGroupType.category ? id : null,
      categoryNotIn: ['1084'],
      tagIn: contentGroupType == ContentGroupType.tag ? id : null,
      first: postsCount,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const ContentGroupState.failedToLoadData();
        },
        (posts) {
          state = ContentGroupState.loaded(
            posts: posts.posts,
          );
        },
      );
    }
  }
}
