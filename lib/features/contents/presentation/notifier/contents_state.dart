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

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/post.dart';

@immutable
abstract class ContentsState extends Equatable {
  const ContentsState();

  @override
  List<Object> get props => [];
}

class ContentsLoading extends ContentsState {
  const ContentsLoading();
}

class ContentsAppend extends ContentsState {
  final List<Post> posts;
  final int nextPageKey;

  const ContentsAppend({
    required this.posts,
    required this.nextPageKey,
  });

  @override
  List<Object> get props => [
        posts,
        nextPageKey,
      ];
}

class ContentsAppendLast extends ContentsState {
  final List<Post> posts;

  const ContentsAppendLast({
    required this.posts,
  });

  @override
  List<Object> get props => [
        posts,
      ];
}

class ContentsError extends ContentsState {
  final String message;

  const ContentsError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
