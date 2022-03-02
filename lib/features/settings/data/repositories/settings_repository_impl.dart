/* 
 * Copyright (C) 2021  Ahmad Rulim
 * 
 * This file is part of Flutter WordPress.
 * 
 * Flutter WordPress is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Flutter WordPress is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Flutter WordPress.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * @license GPL-3.0-or-later <https://spdx.org/licenses/GPL-3.0-or-later.html>
 */

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/locale_local_data_source.dart';
import '../datasources/theme_local_data_source.dart';

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
  Future<Either<Failure, void>> setTheme({
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
  Future<Either<Failure, void>> setLocale({
    required String languageCode,
  }) async {
    try {
      return Right(await _localeLocalDataSource.setLocale(languageCode));
    } catch (error) {
      return Left(ConfigFailure());
    }
  }
}
