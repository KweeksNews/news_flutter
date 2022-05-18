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

import 'features/home/presentation/notifier/notifier.dart';
import 'features/saved_posts/presentation/notifier/notifier.dart';
import 'features/search/presentation/notifier/notifier.dart';
import 'features/settings/presentation/notifier/notifier.dart';
import 'features/single_post/presentation/notifier/notifier.dart';
import 'features/webview/presentation/notifier/notifier.dart';
import 'injection.dart';

final featuredContentProvider =
    StateNotifierProvider.autoDispose<FeaturedContentNotifier, HomeState>(
  (ref) => getIt<FeaturedContentNotifier>(),
);

final contentGroupProvider = StateNotifierProvider.autoDispose
    .family<ContentGroupNotifier, HomeState, String>(
  (ref, title) => getIt<ContentGroupNotifier>(),
);

final searchProvider =
    StateNotifierProvider.autoDispose<SearchNotifier, SearchState>(
  (ref) => getIt<SearchNotifier>(
    param1: ref.read,
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

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => getIt<ThemeNotifier>(),
);

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => getIt<LocaleNotifier>(),
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
