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

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'config/config.dart';
import 'injection.config.dart';
import 'presentation/pages/home/widgets/content_group.dart';
import 'presentation/pages/home/widgets/featured_content.dart';
import 'presentation/pages/saved_posts/saved_posts_page.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
)
Future<void> configureDependencies() async {
  await getIt.init();
}

@module
abstract class AppInjection {
  @Named('settingsBox')
  @preResolve
  @singleton
  Future<Box<dynamic>> get settingsBox async {
    return await Hive.openBox('settings');
  }

  @Named('gqlCacheBox')
  @preResolve
  @singleton
  Future<Box<Map<dynamic, dynamic>>> get gqlCacheBox async {
    return await Hive.openBox('gqlcache');
  }

  @lazySingleton
  QueryExecutor get queryExecutor {
    return LazyDatabase(
      () async {
        final dbFolder = await getApplicationDocumentsDirectory();
        final file = File(join(dbFolder.path, 'db.sqlite'));
        return NativeDatabase(file);
      },
    );
  }

  @lazySingleton
  GraphQLClient gqlClient(
    @Named('gqlCacheBox') Box<Map<dynamic, dynamic>> box,
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

  @Named('featuredContentWidgetKey')
  @lazySingleton
  GlobalKey<FeaturedContentWidgetState> get featuredContentWidgetKey {
    return GlobalKey<FeaturedContentWidgetState>();
  }

  @Named('contentGroupWidgetKey1')
  @lazySingleton
  GlobalKey<ContentGroupWidgetState> get contentGroupWidgetKey1 {
    return GlobalKey<ContentGroupWidgetState>();
  }

  @Named('contentGroupWidgetKey2')
  @lazySingleton
  GlobalKey<ContentGroupWidgetState> get contentGroupWidgetKey2 {
    return GlobalKey<ContentGroupWidgetState>();
  }

  @Named('contentGroupWidgetKey3')
  @lazySingleton
  GlobalKey<ContentGroupWidgetState> get contentGroupWidgetKey3 {
    return GlobalKey<ContentGroupWidgetState>();
  }

  @Named('contentGroupWidgetKey4')
  @lazySingleton
  GlobalKey<ContentGroupWidgetState> get contentGroupWidgetKey4 {
    return GlobalKey<ContentGroupWidgetState>();
  }

  @Named('savedPostsPageKey')
  @lazySingleton
  GlobalKey<SavedPostsPageState> get savedPostsPageKey {
    return GlobalKey<SavedPostsPageState>();
  }
}
