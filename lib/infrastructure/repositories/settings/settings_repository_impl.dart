// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/error/failures.dart';
import '../../../domain/repositories/settings/settings_repository.dart';
import '../../datasources/settings/locale_local_data_source.dart';
import '../../datasources/settings/theme_local_data_source.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final ThemeLocalDataSource _themeLocalDataSource;
  final LocaleLocalDataSource _localeLocalDataSource;

  SettingsRepositoryImpl(
    this._themeLocalDataSource,
    this._localeLocalDataSource,
  );

  @override
  Future<Either<Failure, ThemeMode>> getTheme() async {
    try {
      return Right(await _themeLocalDataSource.getTheme());
    } catch (error) {
      return Left(ConfigFailure());
    }
  }

  @override
  Future<Either<Failure, ThemeMode>> setTheme({
    required ThemeMode mode,
  }) async {
    try {
      return Right(await _themeLocalDataSource.setTheme(mode));
    } catch (error) {
      return Left(ConfigFailure());
    }
  }

  @override
  Future<Either<Failure, Locale>> getLocale() async {
    try {
      return Right(await _localeLocalDataSource.getLocale());
    } catch (error) {
      return Left(ConfigFailure());
    }
  }

  @override
  Future<Either<Failure, Locale>> setLocale({
    required String languageCode,
  }) async {
    try {
      return Right(await _localeLocalDataSource.setLocale(languageCode));
    } catch (error) {
      return Left(ConfigFailure());
    }
  }
}
