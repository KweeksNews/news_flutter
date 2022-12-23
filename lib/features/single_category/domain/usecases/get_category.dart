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
import 'package:injectable/injectable.dart';

import '../../../../core/domain/entities/category.dart';
import '../../../../core/domain/enums/category_id_type.dart';
import '../../../../core/domain/error/failures.dart';
import '../repositories/single_category_repository.dart';

@lazySingleton
class GetCategory {
  final SingleCategoryRepository _repository;

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
