// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'injection.dart';
import 'presentation/viewmodels/home/notifier.dart';
import 'presentation/viewmodels/saved_posts/notifier.dart';
import 'presentation/viewmodels/search/notifier.dart';
import 'presentation/viewmodels/settings/notifier.dart';
import 'presentation/viewmodels/single_category/notifier.dart';
import 'presentation/viewmodels/single_post/notifier.dart';
import 'presentation/viewmodels/single_tag/notifier.dart';
import 'presentation/viewmodels/single_user/notifier.dart';
import 'presentation/viewmodels/webview/notifier.dart';

final rootNavigatorKeyProvide = Provider<GlobalKey<NavigatorState>>(
  (ref) => getIt<GlobalKey<NavigatorState>>(
    instanceName: 'rootNavigatorKey',
  ),
);

final featuredContentProvider = StateNotifierProvider.autoDispose<
    FeaturedContentNotifier, FeaturedContentState>(
  (ref) => getIt<FeaturedContentNotifier>(),
);

final contentGroupProvider = StateNotifierProvider.autoDispose
    .family<ContentGroupNotifier, ContentGroupState, List<String>>(
  (ref, initialIds) => getIt<ContentGroupNotifier>(
    param1: initialIds,
    param2: ref,
  ),
);

final contentGroupDropdownProvider = StateNotifierProvider.autoDispose
    .family<ContentGroupDropdownNotifier, List<String>, List<String>>(
  (ref, initialIds) => getIt<ContentGroupDropdownNotifier>(
    param1: initialIds,
  ),
);

final searchProvider =
    StateNotifierProvider.autoDispose<SearchNotifier, SearchState>(
  (ref) => getIt<SearchNotifier>(
    param1: ref,
  ),
);

final searchTermProvider =
    StateNotifierProvider.autoDispose<SearchTermNotifier, String>(
  (ref) => getIt<SearchTermNotifier>(),
);

final searchBarFilledStatusProvider =
    StateNotifierProvider.autoDispose<SearchBarFilledStatusNotifier, bool>(
  (ref) => getIt<SearchBarFilledStatusNotifier>(),
);

final savedPostsProvider =
    StateNotifierProvider.autoDispose<SavedPostsNotifier, SavedPostsState>(
  (ref) => getIt<SavedPostsNotifier>(),
);

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => getIt<ThemeNotifier>(
    param1: ref.watch(rootNavigatorKeyProvide),
  ),
);

final localeProvider = StateNotifierProvider<LocaleNotifier, LocaleState>(
  (ref) => getIt<LocaleNotifier>(
    param1: ref.watch(rootNavigatorKeyProvide),
  ),
);

final singleUserProvider =
    StateNotifierProvider.autoDispose<SingleUserNotifier, SingleUserState>(
  (ref) => getIt<SingleUserNotifier>(),
);

final userPostsProvider =
    StateNotifierProvider.autoDispose<UserPostsNotifier, UserPostsState>(
  (ref) => getIt<UserPostsNotifier>(),
);

final singleCategoryProvider = StateNotifierProvider.autoDispose<
    SingleCategoryNotifier, SingleCategoryState>(
  (ref) => getIt<SingleCategoryNotifier>(),
);

final categoryPostsProvider = StateNotifierProvider.autoDispose<
    CategoryPostsNotifier, CategoryPostsState>(
  (ref) => getIt<CategoryPostsNotifier>(),
);

final singleTagProvider =
    StateNotifierProvider.autoDispose<SingleTagNotifier, SingleTagState>(
  (ref) => getIt<SingleTagNotifier>(),
);

final tagPostsProvider =
    StateNotifierProvider.autoDispose<TagPostsNotifier, TagPostsState>(
  (ref) => getIt<TagPostsNotifier>(),
);

final singlePostProvider =
    StateNotifierProvider.autoDispose<SinglePostNotifier, SinglePostState>(
  (ref) => getIt<SinglePostNotifier>(),
);

final relatedPostsProvider =
    StateNotifierProvider.autoDispose<RelatedPostsNotifier, RelatedPostsState>(
  (ref) => getIt<RelatedPostsNotifier>(),
);

final savedPostProvider = StateNotifierProvider<SavedPostNotifier, bool>(
  (ref) => getIt<SavedPostNotifier>(),
);

final lightboxProvider =
    StateNotifierProvider.autoDispose<LightboxNotifier, int>(
  (ref) => getIt<LightboxNotifier>(),
);

final loadingProgressProvider =
    StateNotifierProvider.autoDispose<LoadingProgressNotifier, double>(
  (ref) => getIt<LoadingProgressNotifier>(),
);
