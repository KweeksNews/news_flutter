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

final featuredContentProvider =
    StateNotifierProvider.autoDispose<FeaturedContentNotifier, HomeState>(
  (ref) => getIt<FeaturedContentNotifier>(),
);

final contentGroupProvider = StateNotifierProvider.autoDispose
    .family<ContentGroupNotifier, HomeState, List<String>>(
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
