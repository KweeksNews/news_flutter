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

import '../../domain/usecases/get_identity.dart';
import '../../domain/usecases/set_identity.dart';

@injectable
class IdentityNotifier extends StateNotifier<Map<String, String>> {
  GetIdentity getIdentity;
  SetIdentity setIdentity;

  IdentityNotifier({
    required this.getIdentity,
    required this.setIdentity,
  }) : super({
          'name': '',
          'email': '',
        });

  Future<void> get() async {
    final failureOrIdentity = await getIdentity();

    // TODO implement failure
    failureOrIdentity.fold(
      (failure) => null,
      (identity) {
        state = identity;
      },
    );
  }

  Future<void> set(Map<String, String> identity) async {
    final failureOrBool = await setIdentity(identity: identity);

    // TODO implement failure
    failureOrBool.fold(
      (failure) => null,
      (status) {
        if (status) {
          state = identity;
        }
      },
    );
  }
}
