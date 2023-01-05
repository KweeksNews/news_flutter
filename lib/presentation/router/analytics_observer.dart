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

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@singleton
class AnalyticsObserver extends NavigatorObserver {
  final FirebaseAnalytics analytics;

  AnalyticsObserver(
    this.analytics,
  );

  bool _routeFilter(
    Route<dynamic>? route,
  ) {
    return route is PageRoute;
  }

  void _sendScreenView(
    Route<dynamic> route,
  ) {
    final String? screenClass = route.settings.name;
    final String screenName = GoRouter.of(navigator!.context).location;

    analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenClass!.isNotEmpty ? screenClass : 'Flutter',
    );
  }

  @override
  void didPush(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    super.didPush(route, previousRoute);

    if (_routeFilter(route)) {
      _sendScreenView(route);
    }
  }

  @override
  void didPop(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    super.didPop(route, previousRoute);

    if (previousRoute != null &&
        _routeFilter(previousRoute) &&
        _routeFilter(route)) {
      _sendScreenView(previousRoute);
    }
  }

  @override
  void didRemove(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    super.didPop(route, previousRoute);

    if (previousRoute != null &&
        _routeFilter(previousRoute) &&
        _routeFilter(route)) {
      _sendScreenView(previousRoute);
    }
  }

  @override
  void didReplace({
    Route<dynamic>? newRoute,
    Route<dynamic>? oldRoute,
  }) {
    super.didReplace(
      newRoute: newRoute,
      oldRoute: oldRoute,
    );

    if (newRoute != null && _routeFilter(newRoute)) {
      _sendScreenView(newRoute);
    }
  }
}
