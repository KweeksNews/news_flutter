// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/error/failures.dart';
import '../../domain/repositories/shared/saved_posts_repository.dart';

@lazySingleton
class DeleteSavedPost {
  final SavedPostsRepository _repository;

  DeleteSavedPost(
    this._repository,
  );

  Future<Either<Failure, int>> call({
    required int postId,
  }) async {
    return _repository.deleteSavedPost(
      postId: postId,
    );
  }
}
