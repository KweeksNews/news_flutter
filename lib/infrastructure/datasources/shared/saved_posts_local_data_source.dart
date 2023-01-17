// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/posts.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/error/exceptions.dart';
import '../../database/app_database.dart';
import '../../dtos/post_model.dart';
import '../../dtos/posts_model.dart';

part 'saved_posts_local_data_source.g.dart';

abstract class SavedPostsLocalDataSource {
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
    '../../database/queries/saved_posts.drift',
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
