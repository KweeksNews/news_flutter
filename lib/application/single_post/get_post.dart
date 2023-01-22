// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/post.dart';
import '../../domain/entities/post_id.dart';
import '../../domain/error/failures.dart';
import '../../domain/repositories/shared/wp_repository.dart';

@lazySingleton
class GetPost {
  final WpRepository _repository;

  GetPost(
    this._repository,
  );

  Future<Either<Failure, Post>> call({
    required PostId id,
    required bool forceRefresh,
  }) async {
    return _repository.getPost(
      id: id,
      forceRefresh: forceRefresh,
    );
  }
}
