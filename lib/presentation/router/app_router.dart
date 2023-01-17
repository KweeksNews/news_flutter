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
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../config/config.dart';
import '../../domain/enums/category_id_type.dart';
import '../../domain/enums/post_id_type.dart';
import '../../domain/enums/tag_id_type.dart';
import '../../domain/enums/user_node_id_type.dart';
import '../../injection.dart';
import '../l10n/generated/l10n.dart';
import '../pages/home/home_page.dart';
import '../pages/saved_posts/saved_posts_page.dart';
import '../pages/search/search_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/shared/not_found_page.dart';
import '../pages/shared/widgets/navbar.dart';
import '../pages/single_category/single_category_page.dart';
import '../pages/single_post/single_post_page.dart';
import '../pages/single_tag/single_tag_page.dart';
import '../pages/single_user/single_user_page.dart';
import '../pages/webview/webview_page.dart';

@module
abstract class AppRouter {
  @Named('rootNavigatorKey')
  @singleton
  GlobalKey<NavigatorState> get rootNavigatorKey {
    return GlobalKey<NavigatorState>();
  }

  @Named('shellNavigatorKey')
  @singleton
  GlobalKey<NavigatorState> get shellNavigatorKey {
    return GlobalKey<NavigatorState>();
  }

  @singleton
  GoRouter rootRouter(
    @Named('rootNavigatorKey') GlobalKey<NavigatorState> rootNavigatorKey,
    @Named('shellNavigatorKey') GlobalKey<NavigatorState> shellNavigatorKey,
  ) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      errorBuilder: (context, state) {
        return const NotFoundPage();
      },
      routes: <RouteBase>[
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return NavBar(
              child: child,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              name: 'Home',
              path: '/',
              builder: (context, state) {
                return const HomePage();
              },
              routes: <RouteBase>[
                GoRoute(
                  name: 'SingleUser',
                  path: 'users/:slug',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) {
                    return SingleUser(
                      id: state.params['slug']!,
                      idType: UserNodeIdType.slug,
                      slug: state.extra as String?,
                    );
                  },
                ),
                GoRoute(
                  name: 'SingleCategory',
                  path: 'categories/:slug',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) {
                    return SingleCategoryPage(
                      id: state.params['slug']!,
                      idType: CategoryIdType.slug,
                      name: state.extra as String?,
                    );
                  },
                ),
                GoRoute(
                  name: 'SingleTag',
                  path: 'tags/:slug',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) {
                    return SingleTagPage(
                      id: state.params['slug']!,
                      idType: TagIdType.slug,
                      name: state.extra as String?,
                    );
                  },
                ),
                GoRoute(
                  name: 'SinglePost',
                  path: 'posts/:slug',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) {
                    return SinglePostPage(
                      id: state.params['slug']!,
                      idType: PostIdType.slug,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              name: 'Search',
              path: '/search',
              builder: (context, state) {
                return const Search();
              },
            ),
            GoRoute(
              name: 'SavedPosts',
              path: '/saved-posts',
              builder: (context, state) {
                return SavedPostsPage(
                  key: getIt<GlobalKey<SavedPostsPageState>>(
                    instanceName: 'savedPostsPageKey',
                  ),
                );
              },
            ),
            GoRoute(
              name: 'Settings',
              path: '/settings',
              builder: (context, state) {
                return const SettingsPage();
              },
            ),
          ],
        ),
        GoRoute(
          name: 'Contact',
          path: '/contact',
          parentNavigatorKey: getIt<GlobalKey<NavigatorState>>(
            instanceName: 'rootNavigatorKey',
          ),
          builder: (context, state) {
            return WebviewPage(
              title: AppLocalizations.of(context).pageContactTitle,
              url: 'https://${CONFIG.hostName}${state.location}',
              javascript: '''
                let header = document.getElementsByClassName('td-header-template-wrap')[0];
                let footer = document.getElementsByClassName('td-footer-template-wrap')[0];
                let sidebar = document.getElementsByClassName('td-is-sticky')[0];
                header.parentNode.removeChild(header);
                footer.parentNode.removeChild(footer);
                sidebar.parentNode.removeChild(sidebar);
              ''',
            );
          },
        ),
        GoRoute(
          name: 'SubmitContent',
          path: '/submit-content',
          parentNavigatorKey: getIt<GlobalKey<NavigatorState>>(
            instanceName: 'rootNavigatorKey',
          ),
          builder: (context, state) {
            return WebviewPage(
              title: AppLocalizations.of(context).pageSubmitContentTitle,
              url: 'https://${CONFIG.hostName}${state.location}',
              javascript: '''
                let header = document.getElementsByClassName('td-header-template-wrap')[0];
                let footer = document.getElementsByClassName('td-footer-template-wrap')[0];
                let sidebar = document.getElementsByClassName('td-is-sticky')[0];
                header.parentNode.removeChild(header);
                footer.parentNode.removeChild(footer);
                sidebar.parentNode.removeChild(sidebar);
              ''',
            );
          },
        ),
      ],
    );
  }
}
