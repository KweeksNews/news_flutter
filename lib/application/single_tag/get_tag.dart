// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/tag.dart';
import '../../domain/entities/tag_id.dart';
import '../../domain/error/failures.dart';
import '../../domain/repositories/shared/wp_repository.dart';

@lazySingleton
class GetTag {
  final WpRepository _repository;

  GetTag(
    this._repository,
  );

  Future<Either<Failure, Tag>> call({
    required TagId id,
    required bool forceRefresh,
  }) async {
    return _repository.getTag(
      id: id,
      forceRefresh: forceRefresh,
    );
  }
}
