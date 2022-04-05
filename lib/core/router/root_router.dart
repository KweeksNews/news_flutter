import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kweeksnews_app/core/types/post_id_type.dart';
import 'package:kweeksnews_app/features/single_post/presentation/pages/single_post.dart';

import '../../features/webview/presentation/page/webview.dart';
import '../config/config.dart';
import '../l10n/generated/l10n.dart';
import '../widgets/navbar.dart';

final rootRouter = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  routes: <GoRoute>[
    GoRoute(
      name: 'Home',
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage<void>(
          key: const ValueKey('/navbar'),
          child: NavBar(
            index: 0,
            state: state,
          ),
        );
      },
      routes: <GoRoute>[
        GoRoute(
          name: 'Single Post',
          path: 'posts/:slug',
          builder: (BuildContext context, GoRouterState state) {
            return SinglePost(
              id: state.params['slug']!,
              idType: PostIdType.SLUG,
            );
          },
        ),
      ],
    ),
    GoRoute(
      name: 'Search',
      path: '/search',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage<void>(
          key: const ValueKey('/navbar'),
          child: NavBar(
            index: 1,
            state: state,
          ),
        );
      },
    ),
    GoRoute(
      name: 'Saved Posts',
      path: '/saved-posts',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage<void>(
          key: const ValueKey('/navbar'),
          child: NavBar(
            index: 2,
            state: state,
          ),
        );
      },
    ),
    GoRoute(
      name: 'Settings',
      path: '/settings',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage<void>(
          key: const ValueKey('/navbar'),
          child: NavBar(
            index: 3,
            state: state,
          ),
        );
      },
    ),
    GoRoute(
      name: 'Contact',
      path: '/contact',
      builder: (BuildContext context, GoRouterState state) {
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
      name: 'Submit Content',
      path: '/submit-content',
      builder: (BuildContext context, GoRouterState state) {
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
