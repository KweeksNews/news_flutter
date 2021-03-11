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

import 'package:intl/intl.dart';

import '../entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    required int id,
    required String author,
    required String avatar,
    required String date,
    required String content,
  }) : super(
          id: id,
          author: author,
          avatar: avatar,
          date: date,
          content: content,
        );

  factory CommentModel.fromJson(Map<dynamic, dynamic> json) {
    return CommentModel(
      id: json['id'] as int,
      author: json['author_name'] as String,
      avatar: json['author_avatar_urls']['48'] as String,
      date: DateFormat('EEEE, dd MMMM yyyy, H:m', 'id_ID')
          .format(DateTime.parse(json['date'] as String))
          .toString(),
      content: json['content']['rendered'] as String,
    );
  }
}
