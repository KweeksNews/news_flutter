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
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'core/config/config.dart';
import 'core/config/route.dart';
import 'core/router/route_config.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await $initGetIt(getIt);
}

@module
abstract class RegisterModule {
  @Named('settingsBox')
  @preResolve
  @singleton
  Future<Box<dynamic>> get settingsBox async {
    return await Hive.openBox('settings');
  }

  @Named('gqlCacheBox')
  @preResolve
  @singleton
  Future<Box<dynamic>> get gqlCacheBox async {
    return await Hive.openBox('gqlcache');
  }

  @Named('rootNavigatorKey')
  @singleton
  GlobalKey<NavigatorState> get rootNavigatorKey {
    return GlobalKey<NavigatorState>();
  }

  @Named('navBarNavigatorKey')
  @singleton
  GlobalKey<NavigatorState> get navBarNavigatorKey {
    return GlobalKey<NavigatorState>();
  }

  @singleton
  RootBackButtonDispatcher get rootBackButtonDispatcher {
    return RootBackButtonDispatcher();
  }

  @singleton
  RouteConfig get initialRouteConfig {
    return ROUTE.config['home']!;
  }

  @lazySingleton
  GraphQLClient gqlClient(
    @Named('gqlCacheBox') Box<dynamic> box,
  ) {
    return GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore(box),
        dataIdFromObject: (Map<String, Object?> data) {
          final Object? typeName = data['__typename'];
          final Object? databaseId = data['databaseId'];
          final Object? sourceUrl = data['sourceUrl'];

          if (typeName != null && databaseId != null) {
            return '$typeName:$databaseId';
          } else if (typeName != null && sourceUrl != null) {
            return '$typeName:$sourceUrl';
          } else {
            return null;
          }
        },
      ),
      link: HttpLink(
        'https://${CONFIG.hostName}/graphql',
      ),
    );
  }
}
