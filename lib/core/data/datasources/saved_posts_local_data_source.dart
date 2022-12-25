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

import '../../domain/entities/category.dart';
import '../../domain/entities/posts.dart';
import '../../domain/entities/user.dart';
import '../../domain/error/exceptions.dart';
import '../database/app_database.dart';
import '../models/post_model.dart';
import '../models/posts_model.dart';

part 'saved_posts_local_data_source.g.dart';

abstract class SavedPostsLocalDataSource {
  const SavedPostsLocalDataSource();

  Future<int> createSavedPost({
    required PostModel post,
  });

  Future<Posts> readSavedPosts({
    required int postsCount,
    required int pageKey,
  });

  Future<int> updateSavedPost({
    required PostModel post,
  });

  Future<int> deleteSavedPost({
    required int postId,
  });

  Future<bool> checkPostSaveStatus({
    required int postId,
  });
}

@LazySingleton(as: SavedPostsLocalDataSource)
@DriftAccessor(
  include: {
    '../database/queries/saved_posts.drift',
  },
)
class SavedPostsLocalDataSourceImpl extends DatabaseAccessor<AppDatabase>
    with _$SavedPostsLocalDataSourceImplMixin
    implements SavedPostsLocalDataSource {
  SavedPostsLocalDataSourceImpl(
    super.db,
  );

  @override
  Future<int> createSavedPost({
    required PostModel post,
  }) async {
    try {
      final SavedPost data = post.toDB();

      return createEntry(
        data.id,
        data.date,
        data.slug,
        data.title,
        data.image,
        data.video,
        data.author,
        data.categories,
      );
    } catch (error) {
      throw DatabaseException();
    }
  }

  @override
  Future<Posts> readSavedPosts({
    required int postsCount,
    required int pageKey,
  }) async {
    try {
      final List<SavedPost> posts =
          await readAllEntries((pageKey - 1) * postsCount).get();
      final int count = await countEntry().getSingle();

      return PostsModel.fromDB(
        posts,
        count,
      );
    } catch (error) {
      throw DatabaseException();
    }
  }

  @override
  Future<int> updateSavedPost({
    required PostModel post,
  }) async {
    try {
      final SavedPost data = post.toDB();

      return await updateEntry(
        data.id,
        data.date,
        data.slug,
        data.title,
        data.image,
        data.video,
        data.author,
        data.categories,
      );
    } catch (error) {
      throw DatabaseException();
    }
  }

  @override
  Future<int> deleteSavedPost({
    required int postId,
  }) async {
    try {
      return deleteEntry(postId);
    } catch (error) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> checkPostSaveStatus({
    required int postId,
  }) async {
    try {
      final savedPost = await readEntry(postId).getSingleOrNull();

      return savedPost != null;
    } catch (error) {
      throw DatabaseException();
    }
  }
}
