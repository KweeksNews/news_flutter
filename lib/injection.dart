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

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
  @preResolve
  @singleton
  Future<Box<dynamic>> get box async => Hive.openBox('settings');

  @Named('rootNavigatorKey')
  @singleton
  GlobalKey<NavigatorState> get rootNavigatorKey => GlobalKey<NavigatorState>();

  @Named('navBarNavigatorKey')
  @singleton
  GlobalKey<NavigatorState> get navBarNavigatorKey =>
      GlobalKey<NavigatorState>();

  @singleton
  RootBackButtonDispatcher get rootBackButtonDispatcher =>
      RootBackButtonDispatcher();

  @singleton
  RouteConfig get initialRouteConfig => ROUTE.config['home']!;

  @lazySingleton
  Dio get dio => Dio()
    ..options = BaseOptions(headers: CONFIG.headers)
    ..interceptors.add(DioCacheInterceptor(options: CONFIG.cacheOptions))
    ..httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: 10000,
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ),
    );
}
