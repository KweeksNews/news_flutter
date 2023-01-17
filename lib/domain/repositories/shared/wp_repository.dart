// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';

import '../../entities/category.dart';
import '../../entities/post.dart';
import '../../entities/posts.dart';
import '../../entities/tag.dart';
import '../../entities/user.dart';
import '../../enums/category_id_type.dart';
import '../../enums/post_id_type.dart';
import '../../enums/tag_id_type.dart';
import '../../enums/user_node_id_type.dart';
import '../../error/failures.dart';

abstract class WpRepository {
  Future<Either<Failure, User>> getUser({
    required String id,
    required UserNodeIdType idType,
    required bool forceRefresh,
  });

  Future<Either<Failure, Category>> getCategory({
    required String id,
    required CategoryIdType idType,
    required bool forceRefresh,
  });

  Future<Either<Failure, Tag>> getTag({
    required String id,
    required TagIdType idType,
    required bool forceRefresh,
  });

  Future<Either<Failure, Post>> getPost({
    required String id,
    required PostIdType idType,
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
