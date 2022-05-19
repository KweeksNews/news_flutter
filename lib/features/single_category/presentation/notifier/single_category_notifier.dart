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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/types/category_id_type.dart';
import '../../../../core/types/state_exception_type.dart';
import '../../domain/usecases/get_category.dart';
import 'notifier.dart';

@injectable
class SingleCategoryNotifier extends StateNotifier<SingleCategoryState> {
  final GetCategory _getCategory;

  SingleCategoryNotifier(
    this._getCategory,
  ) : super(const SingleCategoryLoading());

  Future<void> fetchCategory({
    required String id,
    required CategoryIdType idType,
    bool forceRefresh = false,
  }) async {
    state = const SingleCategoryLoading();

    final failureOrCategory = await _getCategory(
      id: id,
      idType: idType,
      forceRefresh: forceRefresh,
    );

    if (!mounted) {
      return;
    } else {
      failureOrCategory.fold(
        (failure) {
          state = const SingleCategoryException(
            type: StateExceptionType.failedToLoadData,
          );
        },
        (categoryData) {
          state = SingleCategoryLoaded(
            category: categoryData,
          );
        },
      );
    }
  }
}
