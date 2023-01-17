// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/error/failures.dart';
import '../../domain/repositories/settings/settings_repository.dart';

@lazySingleton
class GetLocale {
  final SettingsRepository _repository;

  GetLocale(
    this._repository,
  );

  Future<Either<Failure, Locale>> call() async {
    return _repository.getLocale();
  }
}
