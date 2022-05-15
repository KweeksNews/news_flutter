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

import '../../../../core/entities/post.dart';

abstract class RelatedPostsState extends Equatable {
  const RelatedPostsState();

  @override
  List<Object> get props => [];
}

class RelatedPostsLoading extends RelatedPostsState {
  const RelatedPostsLoading();
}

class RelatedPostsLoaded extends RelatedPostsState {
  final List<Post> posts;

  const RelatedPostsLoaded({
    required this.posts,
  });

  @override
  List<Object> get props {
    return [
      posts,
    ];
  }
}

class RelatedPostsException extends RelatedPostsState {
  final String message;
  final String image;

  const RelatedPostsException({
    required this.message,
    required this.image,
  });

  @override
  List<Object> get props {
    return [
      message,
      image,
    ];
  }
}
