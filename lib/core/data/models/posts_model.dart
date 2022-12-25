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

import '../../domain/entities/posts.dart';
import '../database/app_database.dart';
import '../models/post_model.dart';

class PostsModel extends Posts {
  const PostsModel({
    required super.posts,
    super.hasNextPage,
    super.hasPreviousPage,
    super.startCursor,
    super.endCursor,
    super.totalPosts,
  });

  factory PostsModel.fromGraphQLJson(
    Map<String, dynamic> data,
  ) {
    return PostsModel(
      posts: List.from(
        (data['nodes'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((d) => PostModel.fromGraphQLJson(d)),
      ),
      hasNextPage: data['pageInfo']['hasNextPage'] as bool,
      hasPreviousPage: data['pageInfo']['hasPreviousPage'] as bool,
      startCursor: data['pageInfo']['startCursor'] as String? ?? '',
      endCursor: data['pageInfo']['endCursor'] as String? ?? '',
    );
  }

  factory PostsModel.fromDB(
    List<SavedPost> data,
    int count,
  ) {
    return PostsModel(
      posts: List.from(
        data.map((d) => PostModel.fromDB(d)),
      ),
      totalPosts: count,
    );
  }
}
