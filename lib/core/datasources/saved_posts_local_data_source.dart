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

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../databases/databases.dart';
import '../databases/saved_post.dart';
import '../entities/post_list.dart';
import '../error/exceptions.dart';
import '../models/post_list_model.dart';
import '../models/post_model.dart';

part 'saved_posts_local_data_source.g.dart';

@lazySingleton
@DriftAccessor(tables: [SavedPosts])
class SavedPostsLocalDataSource extends DatabaseAccessor<AppDatabase>
    with _$SavedPostsLocalDataSourceMixin {
  SavedPostsLocalDataSource(
    super.db,
  );

  Future<int> createSavedPost({
    required PostModel post,
  }) async {
    try {
      return into(savedPosts).insert(post.toDB());
    } catch (error) {
      throw DatabaseException();
    }
  }

  Future<PostList> readSavedPosts({
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

  Future<int> deleteSavedPost({
    required int postId,
  }) async {
    try {
      return (delete(savedPosts)..where((t) => t.id.equals(postId))).go();
    } catch (error) {
      throw DatabaseException();
    }
  }

  Future<bool> checkPostSaveStatus({
    required int postId,
  }) async {
    try {
      return select(savedPosts).get().then((d) => d.any((p) => p.id == postId));
    } catch (error) {
      throw DatabaseException();
    }
  }
}
