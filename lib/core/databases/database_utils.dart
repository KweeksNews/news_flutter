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
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/author.dart';
import '../entities/category.dart';
import '../entities/post_list.dart';
import '../error/exceptions.dart';
import '../models/author_model.dart';
import '../models/category_model.dart';
import '../models/post_list_model.dart';
import '../models/post_model.dart';

part 'database_utils.g.dart';

@DataClassName('SavedPost')
class SavedPosts extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get slug => text()();
  TextColumn get title => text()();
  TextColumn get image => text()();
  TextColumn get video => text()();
  TextColumn get author => text().map(const AuthorConverter())();
  TextColumn get categories => text().map(const CategoriesConverter())();

  @override
  Set<Column<dynamic>> get primaryKey => {id};
}

@lazySingleton
@DriftDatabase(tables: [SavedPosts], daos: [SavedPostsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          LazyDatabase(
            () async {
              final dbFolder = await getApplicationDocumentsDirectory();
              final file = File(join(dbFolder.path, 'db.sqlite'));
              return NativeDatabase(file);
            },
          ),
        );

  @override
  int get schemaVersion => 1;
}

@lazySingleton
@DriftAccessor(tables: [SavedPosts])
class SavedPostsDao extends DatabaseAccessor<AppDatabase>
    with _$SavedPostsDaoMixin {
  final AppDatabase db;

  SavedPostsDao(
    this.db,
  ) : super(db);

  Future<PostList> getSavedPosts({
    required int pageKey,
  }) async {
    try {
      final raw = (select(savedPosts)
            ..orderBy(
              [(t) => OrderingTerm.desc(t.id)],
            )
            ..limit(10, offset: 10 * pageKey))
          .get();
      final countExp = savedPosts.id.count();
      final count = (selectOnly(savedPosts)..addColumns([countExp]))
          .map((row) => row.read(countExp))
          .getSingle();

      return PostListModel.fromDB(
        await raw,
        await count,
      );
    } catch (error) {
      throw DatabaseException();
    }
  }

  Future<bool> updateSavedPost({
    required PostModel post,
  }) async {
    try {
      return update(savedPosts).replace(post.toDB());
    } catch (error) {
      throw DatabaseException();
    }
  }

  Future<int> createSavedPost({
    required PostModel post,
  }) async {
    try {
      return into(savedPosts).insert(post.toDB());
    } catch (error) {
      throw DatabaseException();
    }
  }

  Future<int> deleteSavedPost({
    required int postId,
  }) async {
    try {
      return (delete(savedPosts)..where((t) => t.id.equals(postId))).go();
    } catch (error) {
      throw DatabaseException();
    }
  }

  Future<bool> isSavedPost({
    required int postId,
  }) async {
    try {
      return select(savedPosts).get().then((d) => d.any((p) => p.id == postId));
    } catch (error) {
      throw DatabaseException();
    }
  }
}
