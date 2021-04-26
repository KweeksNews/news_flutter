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
import '../datasources/identity_data_source.dart';
import '../datasources/theme_data_source.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final IdentityDataSource identityDataSource;
  final ThemeDataSource themeDataSource;

  SettingsRepositoryImpl({
    required this.identityDataSource,
    required this.themeDataSource,
  });

  @override
  Future<Either<Failure, Map<String, String>>> getIdentity() async {
    try {
      return Right(await identityDataSource.getIdentity());
    } catch (error) {
      return Left(ConfigFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setIdentity({
    required Map<String, String> identity,
  }) async {
    try {
      return Right(await identityDataSource.setIdentity(identity));
    } catch (error) {
      return Left(ConfigFailure());
    }
  }

  @override
  Future<Either<Failure, ThemeMode>> getTheme() async {
    try {
      return Right(await themeDataSource.getTheme());
    } catch (error) {
      return Left(ConfigFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setTheme({
    required ThemeMode mode,
  }) async {
    try {
      return Right(await themeDataSource.setTheme(mode));
    } catch (error) {
      return Left(ConfigFailure());
    }
  }
}