// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/entities/user_id.dart';
import '../../domain/error/failures.dart';
import '../../domain/repositories/shared/wp_repository.dart';

@lazySingleton
class GetUser {
  final WpRepository _repository;

  GetUser(
    this._repository,
  );

  Future<Either<Failure, User>> call({
    required UserId id,
    required bool forceRefresh,
  }) async {
    return _repository.getUser(
      id: id,
      forceRefresh: forceRefresh,
    );
  }
}
