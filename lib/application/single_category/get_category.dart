// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/category.dart';
import '../../domain/enums/category_id_type.dart';
import '../../domain/error/failures.dart';
import '../../domain/repositories/shared/wp_repository.dart';

@lazySingleton
class GetCategory {
  final WpRepository _repository;

  GetCategory(
    this._repository,
  );

  Future<Either<Failure, Category>> call({
    required String id,
    required CategoryIdType idType,
    required bool forceRefresh,
  }) async {
    return _repository.getCategory(
      id: id,
      idType: idType,
      forceRefresh: forceRefresh,
    );
  }
}
