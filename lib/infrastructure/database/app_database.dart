// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/user.dart';
import '../datasources/shared/saved_posts_local_data_source.dart';
import '../dtos/category_model.dart';
import '../dtos/user_model.dart';

part 'app_database.g.dart';

@lazySingleton
@DriftDatabase(
  include: {
    'tables/saved_posts.drift',
  },
  daos: [SavedPostsLocalDataSourceImpl],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(
    QueryExecutor e,
  ) : super(e);

  @override
  int get schemaVersion => 1;
}
