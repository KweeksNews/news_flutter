// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';

import '../../entities/post.dart';
import '../../entities/posts.dart';
import '../../error/failures.dart';

abstract class SavedPostsRepository {
  Future<Either<Failure, int>> addSavedPost({
    required Post post,
  });

  Future<Either<Failure, Posts>> getSavedPosts({
    required int postsCount,
    required int pageKey,
  });

  Future<Either<Failure, int>> deleteSavedPost({
    required int postId,
  });

  Future<Either<Failure, bool>> checkPostSaveStatus({
    required int postId,
  });
}
