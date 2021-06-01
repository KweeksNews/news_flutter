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

import 'features/comments/presentation/notifier/notifier.dart';
import 'features/contents/presentation/notifier/notifier.dart';
import 'features/navbar/presentation/notifier/navbar_notifier.dart';
import 'features/saved_posts/presentation/notifier/notifier.dart';
import 'features/search/presentation/notifier/notifier.dart';
import 'features/settings/presentation/notifier/notifier.dart';
import 'features/single_post/presentation/notifier/notifier.dart';
import 'injection.dart';

final navBarProvider = StateNotifierProvider<NavBarNotifier, int>(
  (ref) => getIt<NavBarNotifier>(),
);

final contentsProvider = StateNotifierProvider.autoDispose
    .family<ContentsNotifier, ContentsState, String>(
  (ref, catId) => getIt<ContentsNotifier>(param1: catId),
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

final commentsProvider =
    StateNotifierProvider.autoDispose<CommentsNotifier, CommentsState>(
  (ref) => getIt<CommentsNotifier>(),
);

final searchProvider =
    StateNotifierProvider.autoDispose<SearchNotifier, SearchState>(
  (ref) => getIt<SearchNotifier>(),
);

final searchFieldProvider =
    StateNotifierProvider.autoDispose<SearchFieldNotifier, bool>(
  (ref) => getIt<SearchFieldNotifier>(),
);

final savedPostsProvider =
    StateNotifierProvider.autoDispose<SavedPostsNotifier, SavedPostsState>(
  (ref) => getIt<SavedPostsNotifier>(),
);

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => getIt<ThemeNotifier>(),
);

final identityProvider =
    StateNotifierProvider<IdentityNotifier, Map<String, String>>(
  (ref) => getIt<IdentityNotifier>(),
);
