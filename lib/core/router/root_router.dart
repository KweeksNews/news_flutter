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

import '../../features/home/presentation/pages/home.dart';
import '../../features/saved_posts/presentation/pages/saved_posts.dart';
import '../../features/search/presentation/pages/search.dart';
import '../../features/settings/presentation/pages/settings.dart';
import '../../features/single_category/presentation/pages/single_category.dart';
import '../../features/single_post/presentation/pages/single_post.dart';
import '../../features/single_tag/presentation/pages/single_tag.dart';
import '../../features/single_user/presentation/pages/single_user.dart';
import '../../features/webview/presentation/page/webview.dart';
import '../../injection.dart';
import '../config/config.dart';
import '../l10n/generated/l10n.dart';
import '../types/category_id_type.dart';
import '../types/post_id_type.dart';
import '../types/tag_id_type.dart';
import '../types/user_node_id_type.dart';
import '../widgets/navbar.dart';

@singleton
class RootRouter {
  const RootRouter();

  GoRouter get router {
    return GoRouter(
      navigatorKey: getIt<GlobalKey<NavigatorState>>(
        instanceName: 'rootNavigatorKey',
      ),
      initialLocation: '/',
      routes: <RouteBase>[
        ShellRoute(
          navigatorKey: getIt<GlobalKey<NavigatorState>>(
            instanceName: 'shellNavigatorKey',
          ),
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
                return const Home();
              },
              routes: <RouteBase>[
                GoRoute(
                  name: 'SingleUser',
                  path: 'users/:slug',
                  parentNavigatorKey: getIt<GlobalKey<NavigatorState>>(
                    instanceName: 'rootNavigatorKey',
                  ),
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
                  parentNavigatorKey: getIt<GlobalKey<NavigatorState>>(
                    instanceName: 'rootNavigatorKey',
                  ),
                  builder: (context, state) {
                    return SingleCategory(
                      id: state.params['slug']!,
                      idType: CategoryIdType.slug,
                      name: state.extra as String?,
                    );
                  },
                ),
                GoRoute(
                  name: 'SingleTag',
                  path: 'tags/:slug',
                  parentNavigatorKey: getIt<GlobalKey<NavigatorState>>(
                    instanceName: 'rootNavigatorKey',
                  ),
                  builder: (context, state) {
                    return SingleTag(
                      id: state.params['slug']!,
                      idType: TagIdType.slug,
                      name: state.extra as String?,
                    );
                  },
                ),
                GoRoute(
                  name: 'SinglePost',
                  path: 'posts/:slug',
                  parentNavigatorKey: getIt<GlobalKey<NavigatorState>>(
                    instanceName: 'rootNavigatorKey',
                  ),
                  builder: (context, state) {
                    return SinglePost(
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
                return SavedPosts(
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
                return const Settings();
              },
            ),
          ],
        ),
        GoRoute(
          name: 'Contact',
          path: '/contact',
          builder: (context, state) {
            return Webview(
              title: AppLocalizations.current.pageContactTitle,
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
          builder: (context, state) {
            return Webview(
              title: AppLocalizations.current.pageSubmitContentTitle,
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
