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

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../features/navbar/presentation/pages/navbar.dart';
import '../../features/single_post/presentation/pages/single_post.dart';
import '../../features/webview/presentation/page/webview.dart';
import '../config/config.dart';
import '../config/route.dart';
import '../l10n/generated/l10n.dart';
import '../types/post_id_type.dart';
import 'route_action.dart';
import 'route_config.dart';
import 'route_state_notifier.dart';

@singleton
class RootRouterDelegate extends RouterDelegate<RouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfig> {
  final List<Page<dynamic>> _pages = [];

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final RouteStateNotifier routeStateNotifier;

  RootRouterDelegate(
    @Named('rootNavigatorKey') this.navigatorKey,
    this.routeStateNotifier,
  ) {
    routeStateNotifier.addListener(notifyListeners);
  }

  @override
  RouteConfig? get currentConfiguration {
    return _pages.isEmpty ? null : _pages.last.arguments as RouteConfig;
  }

  @override
  void dispose() {
    routeStateNotifier.removeListener(notifyListeners);
    routeStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: _buildPages(),
    );
  }

  @override
  Future<void> setNewRoutePath(
    RouteConfig configuration,
  ) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as RouteConfig).key != configuration.key;

    if (shouldAddPage) {
      _pages.clear();
      routeStateNotifier.setCurrentRootAction(
        RouteAction(
          state: RouteActionState.push,
          page: configuration,
        ),
      );
    }

    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() {
    if (_canPop()) {
      _removePage(_pages.last);
      return SynchronousFuture(true);
    } else {
      return SynchronousFuture(false);
    }
  }

  bool _canPop() {
    return _pages.length > 1;
  }

  void _addPage(
    Widget child,
    RouteConfig configuration,
  ) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as RouteConfig).key != configuration.key;

    if (shouldAddPage) {
      _pages.add(
        MaterialPage(
          key: ValueKey(configuration.key),
          name: configuration.path,
          arguments: configuration,
          child: child,
        ),
      );
    }
  }

  void _removePage(
    Page<dynamic> page,
  ) {
    _pages.remove(page);
  }

  void push(
    RouteConfig configuration,
  ) {
    String? key;
    Widget? child;

    switch (configuration.name) {
      case RouteName.home:
      case RouteName.search:
      case RouteName.savedPosts:
      case RouteName.settings:
        routeStateNotifier.setCurrentNavBarAction(
          routeStateNotifier.currentRootAction,
        );
        key = 'NavBarPage';
        child = const NavBar();
        break;
      case RouteName.singlePost:
        key = 'SinglePostPage${configuration.parameters!['slug']!}';
        child = SinglePost(
          id: configuration.parameters!['slug']!,
          idType: PostIdType.SLUG,
        );
        break;
      case RouteName.contact:
        child = Webview(
          title: AppLocalizations.current.pageContactTitle,
          url: 'https://${CONFIG.hostName}${configuration.path}',
          javascript: '''
            let header = document.getElementsByClassName('td-header-template-wrap')[0];
            header.parentNode.removeChild(header);
            let footer = document.getElementsByClassName('td-footer-template-wrap')[0];
            footer.parentNode.removeChild(footer);
            let sidebar = document.getElementsByClassName('td-is-sticky')[0];
            sidebar.parentNode.removeChild(sidebar);
          ''',
        );
        break;
      default:
        break;
    }

    if (child != null) {
      _addPage(
        child,
        configuration.copyWith(
          key: key ?? configuration.key,
        ),
      );
    }
  }

  void pushAll(
    List<RouteConfig> configurations,
  ) {
    configurations.forEach((configuration) {
      push(configuration);
    });
  }

  void pushReplacement(
    RouteConfig configuration,
  ) {
    if (_pages.isNotEmpty) {
      _removePage(_pages.last);
    }
    push(configuration);
  }

  void pushWidget(
    Widget child,
    RouteConfig configuration,
  ) {
    _addPage(child, configuration);
  }

  void pop() {
    if (_canPop()) {
      _removePage(_pages.last);
    }
  }

  bool _onPopPage(
    Route<dynamic> route,
    dynamic result,
  ) {
    if (!route.didPop(result)) {
      return false;
    }

    if (_canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  List<Page<dynamic>> _buildPages() {
    switch (routeStateNotifier.currentRootAction.state) {
      case RouteActionState.none:
        break;
      case RouteActionState.push:
        push(
          routeStateNotifier.currentRootAction.page!.copyWith(
            currentRouteAction: routeStateNotifier.currentRootAction,
          ),
        );
        break;
      case RouteActionState.pushWidget:
        pushWidget(
          routeStateNotifier.currentRootAction.widget!,
          routeStateNotifier.currentRootAction.page!,
        );
        break;
      case RouteActionState.pushAll:
        pushAll(
          routeStateNotifier.currentRootAction.pages!,
        );
        break;
      case RouteActionState.pushReplacement:
        pushReplacement(
          routeStateNotifier.currentRootAction.page!.copyWith(
            currentRouteAction: routeStateNotifier.currentRootAction,
          ),
        );
        break;
      case RouteActionState.pop:
        pop();
        break;
      default:
        break;
    }

    routeStateNotifier.clearCurrentRootAction();

    return List.of(_pages);
  }
}
