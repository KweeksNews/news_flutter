// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';

import '../../entities/category.dart';
import '../../entities/category_id.dart';
import '../../entities/post.dart';
import '../../entities/post_id.dart';
import '../../entities/posts.dart';
import '../../entities/tag.dart';
import '../../entities/tag_id.dart';
import '../../entities/user.dart';
import '../../entities/user_id.dart';
import '../../error/failures.dart';

abstract class WpRepository {
  Future<Either<Failure, User>> getUser({
    required UserId id,
    required bool forceRefresh,
  });

  Future<Either<Failure, Category>> getCategory({
    required CategoryId id,
    required bool forceRefresh,
  });

  Future<Either<Failure, Tag>> getTag({
    required TagId id,
    required bool forceRefresh,
  });

  Future<Either<Failure, Post>> getPost({
    required PostId id,
    required bool forceRefresh,
  });

  Future<Either<Failure, Posts>> getPosts({
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
  });
}
