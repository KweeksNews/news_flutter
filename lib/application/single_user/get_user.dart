// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/enums/user_node_id_type.dart';
import '../../domain/error/failures.dart';
import '../../domain/repositories/shared/wp_repository.dart';

@lazySingleton
class GetUser {
  final WpRepository _repository;

  GetUser(
    this._repository,
  );

  Future<Either<Failure, User>> call({
    required String id,
    required UserNodeIdType idType,
    required bool forceRefresh,
  }) async {
    return _repository.getUser(
      id: id,
      idType: idType,
      forceRefresh: forceRefresh,
    );
  }
}
