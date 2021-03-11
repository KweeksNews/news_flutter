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

import 'package:injectable/injectable.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../entities/post_list.dart';
import '../../error/exceptions.dart';
import '../../models/post_list_model.dart';
import '../../models/post_model.dart';

part 'database_utils.g.dart';

class SavedPosts extends Table {
  IntColumn get id => integer()();
  IntColumn get catId => integer()();
  TextColumn get category => text()();
  TextColumn get date => text()();
  TextColumn get link => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get image => text()();
  TextColumn get video => text().nullable()();
  TextColumn get author => text()();
  TextColumn get avatar => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@lazySingleton
@UseMoor(tables: [SavedPosts], daos: [SavedPostsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'AppData.db',
        ));

  @override
  int get schemaVersion => 1;
}

@lazySingleton
@UseDao(tables: [SavedPosts])
class SavedPostsDao extends DatabaseAccessor<AppDatabase>
    with _$SavedPostsDaoMixin {
  final AppDatabase db;

  SavedPostsDao(this.db) : super(db);

  Future<PostList> getSavedPosts({
    required int pageKey,
  }) async {
    try {
      final raw = (select(savedPosts)
            ..orderBy([
              (t) => OrderingTerm(
                    expression: t.id,
                    mode: OrderingMode.desc,
                  )
            ])
            ..limit(
              10,
              offset: 10 * pageKey,
            ))
          .get();
      final countExp = savedPosts.id.count();
      final count = (selectOnly(savedPosts)..addColumns([countExp]))
          .map((row) => row.read(countExp))
          .getSingle();

      return PostListModel.fromDatabase(await raw, await count);
    } catch (error) {
      throw DatabaseException;
    }
  }

  Future<bool> updateSavedPost({
    required PostModel post,
  }) async {
    try {
      return update(savedPosts).replace(post.toDatabaseJson());
    } catch (error) {
      throw DatabaseException;
    }
  }

  Future<int> createSavedPost({
    required PostModel post,
  }) async {
    try {
      return into(savedPosts).insert(post.toDatabaseJson());
    } catch (error) {
      throw DatabaseException;
    }
  }

  Future<int> deleteSavedPost({
    required int postId,
  }) async {
    try {
      return (delete(savedPosts)..where((t) => t.id.equals(postId))).go();
    } catch (error) {
      throw DatabaseException;
    }
  }

  Future<bool> isSavedPost({
    required int postId,
  }) async {
    try {
      return select(savedPosts).get().then((d) => d.any((p) => p.id == postId));
    } catch (error) {
      throw DatabaseException;
    }
  }
}
