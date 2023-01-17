// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/posts.dart';
import '../../domain/error/failures.dart';
import '../../domain/repositories/shared/saved_posts_repository.dart';

@lazySingleton
class GetSavedPosts {
  final SavedPostsRepository _repository;

  GetSavedPosts(
    this._repository,
  );

  Future<Either<Failure, Posts>> call({
    required int postsCount,
    required int pageKey,
  }) async {
    return _repository.getSavedPosts(
      postsCount: postsCount,
      pageKey: pageKey,
    );
  }
}
