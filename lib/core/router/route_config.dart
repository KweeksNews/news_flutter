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

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../config/route.dart';
import 'route_action.dart';

part 'route_config.g.dart';

@CopyWith(skipFields: true)
class RouteConfig extends Equatable {
  @CopyWithField(immutable: true)
  final RouteName name;
  final String key;
  @CopyWithField(immutable: true)
  final String template;
  final String? path;
  final Map<String, String>? parameters;
  final Map<String, String>? queryParameters;
  final RouteAction? currentRouteAction;

  const RouteConfig({
    required this.name,
    required this.key,
    required this.template,
    this.path,
    this.parameters,
    this.queryParameters,
    this.currentRouteAction,
  });

  @override
  List<Object?> get props {
    return [
      name,
      key,
      template,
      path,
      parameters,
      queryParameters,
      currentRouteAction,
    ];
  }
}
