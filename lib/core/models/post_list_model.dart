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

import 'package:dio/dio.dart';

import '../databases/database_utils.dart';
import '../entities/post.dart';
import '../entities/post_list.dart';
import '../models/post_model.dart';

class PostListModel extends PostList {
  const PostListModel({
    required List<Post> posts,
    required int totalPosts,
  }) : super(
          posts: posts,
          totalPosts: totalPosts,
        );

  factory PostListModel.fromApiResponse(
    Response<dynamic> response,
  ) {
    return PostListModel(
      posts: List.from(
        (response.data as List<dynamic>).cast<Map<String, dynamic>>().map(
              (Map<String, dynamic> d) => PostModel.fromJson(d),
            ),
      ),
      totalPosts: int.parse(response.headers.value('x-wp-total').toString()),
    );
  }

  factory PostListModel.fromDBJson(
    List<SavedPost> data,
    int count,
  ) {
    return PostListModel(
      posts: List.from(data.map((d) => PostModel.fromDBJson(d))),
      totalPosts: count,
    );
  }
}
