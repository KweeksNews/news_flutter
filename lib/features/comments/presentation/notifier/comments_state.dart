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

import '../../../../core/entities/comment.dart';

@immutable
abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsLoading extends CommentsState {
  const CommentsLoading();
}

class CommentsAppend extends CommentsState {
  final List<Comment> comments;
  final int nextPageKey;

  const CommentsAppend({
    required this.comments,
    required this.nextPageKey,
  });

  @override
  List<Object> get props => [
        comments,
        nextPageKey,
      ];
}

class CommentsAppendLast extends CommentsState {
  final List<Comment> comments;

  const CommentsAppendLast({
    required this.comments,
  });

  @override
  List<Object> get props => [
        comments,
      ];
}

class CommentsError extends CommentsState {
  final String message;

  const CommentsError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
