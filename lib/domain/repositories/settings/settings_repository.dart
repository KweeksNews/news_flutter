// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, ThemeMode>> getTheme();

  Future<Either<Failure, ThemeMode>> setTheme({
    required ThemeMode mode,
  });

  Future<Either<Failure, Locale>> getLocale();

  Future<Either<Failure, Locale>> setLocale({
    required String languageCode,
  });
}
