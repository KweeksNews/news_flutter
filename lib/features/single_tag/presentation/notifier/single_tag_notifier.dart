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

import '../../../../core/domain/enums/state_exception_type.dart';
import '../../../../core/domain/enums/tag_id_type.dart';
import '../../domain/usecases/get_tag.dart';
import 'notifier.dart';

@injectable
class SingleTagNotifier extends StateNotifier<SingleTagState> {
  final GetTag _getTag;

  SingleTagNotifier(
    this._getTag,
  ) : super(const SingleTagLoading());

  Future<void> fetchTag({
    required String id,
    required TagIdType idType,
    bool forceRefresh = false,
  }) async {
    state = const SingleTagLoading();

    final failureOrTag = await _getTag(
      id: id,
      idType: idType,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrTag.fold(
        (failure) {
          state = const SingleTagException(
            type: StateExceptionType.failedToLoadData,
          );
        },
        (tagData) {
          state = SingleTagLoaded(
            tag: tagData,
          );
        },
      );
    }
  }
}
