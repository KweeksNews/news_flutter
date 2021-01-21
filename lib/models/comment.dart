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

class Comment {
  final int id;
  final String author;
  final String avatar;
  final String date;
  final String content;

  const Comment({
    this.id,
    this.author,
    this.avatar,
    this.date,
    this.content,
  });

  factory Comment.fromJson(Map<dynamic, dynamic> json) {
    final int id = json['id'] as int;
    final String author = json['author_name'] as String;
    final String avatar = json['author_avatar_urls']['48'] as String;
    final String date = DateFormat('EEEE, dd MMMM yyyy, H:m', 'id_ID')
        .format(DateTime.parse(json['date'] as String))
        .toString();
    final content = json['content']['rendered'] as String;

    return Comment(
      id: id,
      author: author,
      avatar: avatar,
      date: date,
      content: content,
    );
  }
}
