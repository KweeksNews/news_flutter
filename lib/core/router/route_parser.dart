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
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:path_to_regexp/path_to_regexp.dart';

import '../config/route.dart';
import 'route_config.dart';

@singleton
class RouteParser extends RouteInformationParser<RouteConfig> {
  final RouteConfig initialRoute;

  const RouteParser(
    this.initialRoute,
  );

  @override
  Future<RouteConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    const Map<String, String> pattern = ROUTE.pattern;
    final Uri uri = Uri.parse(routeInformation.location!);
    final String path = uri.path.endsWith('/') && uri.path != '/'
        ? uri.path.substring(0, uri.path.length - 1)
        : routeInformation.location!;
    final Map<String, String> queryParameters = uri.queryParameters;
    RouteConfig parsedRoute = initialRoute;

    pattern.forEach((key, value) {
      final List<String> parameterKeys = [];
      final RegExp regExp = pathToRegExp(value, parameters: parameterKeys);

      if (regExp.hasMatch(path)) {
        final Match? match = regExp.matchAsPrefix(path);
        final Map<String, String> parameters = extract(parameterKeys, match!);

        parsedRoute = RouteConfig(
          name: ROUTE.config[key]!.name,
          key: ROUTE.config[key]!.key,
          template: ROUTE.config[key]!.template,
          path: path,
          parameters: parameters,
          queryParameters: queryParameters,
        );
      }
    });

    return SynchronousFuture(parsedRoute);
  }

  @override
  RouteInformation restoreRouteInformation(
    RouteConfig configuration,
  ) {
    return RouteInformation(
      location: configuration.path,
    );
  }
}
