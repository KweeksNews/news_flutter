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
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeAppend extends HomeState {
  final List<Post> posts;
  final String nextPageKey;

  const HomeAppend({
    required this.posts,
    required this.nextPageKey,
  });

  @override
  List<Object> get props {
    return [
      posts,
      nextPageKey,
    ];
  }
}

class HomeAppendLast extends HomeState {
  final List<Post> posts;

  const HomeAppendLast({
    required this.posts,
  });

  @override
  List<Object> get props {
    return [
      posts,
    ];
  }
}

class HomeError extends HomeState {
  final String message;
  final String image;

  const HomeError({
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