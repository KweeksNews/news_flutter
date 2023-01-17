// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

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
