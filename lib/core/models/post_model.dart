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

import '../datasources/databases/database_utils.dart';
import '../entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required int id,
    required String title,
    required String content,
    required String image,
    required String video,
    required String author,
    required String avatar,
    required String category,
    required String date,
    required String link,
    required int catId,
  }) : super(
          id: id,
          title: title,
          content: content,
          image: image,
          video: video,
          author: author,
          avatar: avatar,
          category: category,
          date: date,
          link: link,
          catId: catId,
        );

  factory PostModel.fromResponseJson(Map<dynamic, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: json['title']['rendered'] as String,
      content:
          json['content'] != null ? json['content']['rendered'] as String : '',
      image: json['custom']['featured_image'] != ''
          ? json['custom']['featured_image'] as String
          : 'https://www.kweeksnews.com/wp-content/uploads/2021/01/placeholder.png',
      video: json['custom']['td_video'] as String,
      author: json['custom']['author']['name'] as String,
      avatar: json['custom']['author']['avatar'] as String,
      category: json['custom']['categories'] != ''
          ? json['custom']['categories'][0]['name'] as String
          : '',
      catId: json['custom']['categories'] != ''
          ? json['custom']['categories'][0]['cat_ID'] as int
          : 0,
      date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
          .format(DateTime.parse(json['date'] as String))
          .toString(),
      link: json['link'] as String,
    );
  }

  factory PostModel.fromDatabaseJson(SavedPost data) {
    return PostModel(
      id: data.id,
      title: data.title,
      content: data.content,
      image: data.image,
      video: data.video != '' ? data.video! : '',
      author: data.author,
      avatar: data.avatar,
      category: data.category,
      date: data.date,
      link: data.link,
      catId: data.catId,
    );
  }

  SavedPost toDatabaseJson() {
    return SavedPost(
      id: id,
      title: title,
      content: content,
      image: image,
      video: video,
      author: author,
      avatar: avatar,
      category: category,
      date: date,
      link: link,
      catId: catId,
    );
  }
}
