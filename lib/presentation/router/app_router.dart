// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../config/config.dart';
import '../../domain/entities/category_id.dart';
import '../../domain/entities/post_id.dart';
import '../../domain/entities/tag_id.dart';
import '../../domain/entities/user_id.dart';
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
                      id: UserId.slug(state.params['slug']!),
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
                      id: CategoryId.slug(state.params['slug']!),
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
                      id: TagId.slug(state.params['slug']!),
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
                      id: PostId.slug(state.params['slug']!),
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
