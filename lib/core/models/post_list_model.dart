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

import '../databases/database_utils.dart';
import '../entities/post.dart';
import '../entities/post_list.dart';
import '../models/post_model.dart';

class PostListModel extends PostList {
  const PostListModel({
    required List<Post> posts,
    bool? hasNextPage,
    bool? hasPreviousPage,
    String? startCursor,
    String? endCursor,
    int? totalPosts,
  }) : super(
          posts: posts,
          hasNextPage: hasNextPage,
          hasPreviousPage: hasPreviousPage,
          startCursor: startCursor,
          endCursor: endCursor,
          totalPosts: totalPosts,
        );

  factory PostListModel.fromGraphQLJson(
    Map<String, dynamic> data,
  ) {
    return PostListModel(
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

  factory PostListModel.fromDB(
    List<SavedPost> data,
    int count,
  ) {
    return PostListModel(
      posts: List.from(
        data.map((d) => PostModel.fromDB(d)),
      ),
      totalPosts: count,
    );
  }
}
