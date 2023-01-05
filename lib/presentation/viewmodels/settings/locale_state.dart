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

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/enums/state_exception_type.dart';

@immutable
abstract class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState({
    required this.locale,
  });

  @override
  List<Object> get props {
    return [
      locale,
    ];
  }
}

class LocaleLoading extends LocaleState {
  const LocaleLoading({
    required super.locale,
  });
}

class LocaleLoaded extends LocaleState {
  const LocaleLoaded({
    required super.locale,
  });
}

class LocaleException extends LocaleState {
  final StateExceptionType type;

  const LocaleException({
    required super.locale,
    required this.type,
  });

  @override
  List<Object> get props {
    return [
      locale,
      type,
    ];
  }
}
