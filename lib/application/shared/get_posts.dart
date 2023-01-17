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
import '../../domain/repositories/shared/wp_repository.dart';

@lazySingleton
class GetPosts {
  final WpRepository _repository;

  GetPosts(
    this._repository,
  );

  Future<Either<Failure, Posts>> call({
    String? search,
    List<String>? notIn,
    List<String>? authorIn,
    List<String>? categoryIn,
    List<String>? categoryNotIn,
    List<String>? tagIn,
    List<String>? tagNotIn,
    int? first,
    String? after,
    int? last,
    String? before,
    required bool forceRefresh,
  }) async {
    return _repository.getPosts(
      search: search,
      notIn: notIn,
      authorIn: authorIn,
      categoryIn: categoryIn,
      categoryNotIn: categoryNotIn,
      tagIn: tagIn,
      tagNotIn: tagNotIn,
      first: first,
      after: after,
      last: last,
      before: before,
      forceRefresh: forceRefresh,
    );
  }
}
