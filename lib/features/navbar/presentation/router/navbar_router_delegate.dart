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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/route.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/router/route_action.dart';
import '../../../../core/router/route_config.dart';
import '../../../../core/router/route_state_notifier.dart';
import '../../../home/presentation/pages/home.dart';
import '../../../saved_posts/presentation/pages/saved_posts.dart';
import '../../../search/presentation/pages/search.dart';
import '../../../settings/presentation/pages/settings.dart';

@singleton
class NavBarRouterDelegate extends RouterDelegate<RouteConfig>
    with ChangeNotifier {
  final List<Page<dynamic>> _pages = [];
  int _currentIndex = 0;

  final GlobalKey<NavigatorState> navigatorKey;
  final RouteStateNotifier routeStateNotifier;

  NavBarRouterDelegate(
    @Named('navBarNavigatorKey') this.navigatorKey,
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
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        onPopPage: _onPopPage,
        pages: _buildPages(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            selectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_rounded),
                label: AppLocalizations.of(context).navBarHomeLabel,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search_rounded),
                label: AppLocalizations.of(context).navBarSearchLabel,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.bookmarks_rounded),
                label: AppLocalizations.of(context).navBarSavedPostsLabel,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.menu_rounded),
                label: AppLocalizations.of(context).navBarSettingsLabel,
              ),
            ],
            currentIndex: _currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() {
    return SynchronousFuture(false);
  }

  void _addPage(
    Widget child,
    RouteConfig configuration,
  ) {
    _pages.add(
      MaterialPage(
        key: ValueKey(configuration.key.toString()),
        name: configuration.path,
        arguments: configuration,
        child: child,
      ),
    );
  }

  void push(
    RouteConfig configuration,
  ) {
    Widget? child;

    switch (configuration.name) {
      case RouteName.home:
        _currentIndex = 0;
        child = const Home();
        break;
      case RouteName.search:
        _currentIndex = 1;
        child = const Search();
        break;
      case RouteName.savedPosts:
        _currentIndex = 2;
        child = const SavedPosts();
        break;
      case RouteName.settings:
        _currentIndex = 3;
        child = const Settings();
        break;
      default:
        break;
    }

    if (child != null) {
      _pages.clear();
      _addPage(
        child,
        configuration.copyWith(
          key: configuration.key,
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

  bool _onPopPage(
    Route<dynamic> route,
    dynamic result,
  ) {
    return false;
  }

  List<Page<dynamic>> _buildPages() {
    switch (routeStateNotifier.currentNavBarAction.state) {
      case RouteActionState.none:
        break;
      case RouteActionState.push:
      case RouteActionState.pushReplacement:
        push(
          routeStateNotifier.currentNavBarAction.page!.copyWith(
            currentRouteAction: routeStateNotifier.currentNavBarAction,
          ),
        );
        break;
      case RouteActionState.pushAll:
        pushAll(
          routeStateNotifier.currentNavBarAction.pages!,
        );
        break;
      default:
        break;
    }

    routeStateNotifier.clearCurrentNavBarAction();

    return List.of(_pages);
  }

  void onTap(int index) {
    switch (index) {
      case 0:
        routeStateNotifier.setCurrentRootAction(
          RouteAction(
            state: RouteActionState.push,
            page: ROUTE.config['home'],
          ),
        );
        break;
      case 1:
        routeStateNotifier.setCurrentRootAction(
          RouteAction(
            state: RouteActionState.push,
            page: ROUTE.config['search'],
          ),
        );
        break;
      case 2:
        routeStateNotifier.setCurrentRootAction(
          RouteAction(
            state: RouteActionState.push,
            page: ROUTE.config['savedPosts'],
          ),
        );
        break;
      case 3:
        routeStateNotifier.setCurrentRootAction(
          RouteAction(
            state: RouteActionState.push,
            page: ROUTE.config['settings'],
          ),
        );
        break;
    }
  }
}
