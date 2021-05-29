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

import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';

import '../datasources/databases/database_utils.dart';
import '../entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required int id,
    required String title,
    required String category,
    required int catId,
    required String author,
    required String date,
    required String image,
    required bool video,
  }) : super(
          id: id,
          title: title,
          category: category,
          catId: catId,
          author: author,
          date: date,
          image: image,
          video: video,
        );

  factory PostModel.fromApiJson(Map<dynamic, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: HtmlUnescape().convert(json['title']['rendered'] as String),
      category: json['custom']['categories']['name'] as String,
      catId: json['custom']['categories']['id'] as int,
      author: json['custom']['author']['name'] as String,
      date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
          .format(DateTime.parse(json['date'] as String))
          .toString(),
      image: json['custom']['featured_image'] as String,
      video: json['custom']['video'] != '',
    );
  }

  factory PostModel.fromDBJson(SavedPost data) {
    return PostModel(
      id: data.id,
      title: data.title,
      category: data.category,
      catId: data.catId,
      author: data.author,
      date: data.date,
      image: data.image,
      video: data.video,
    );
  }

  SavedPost toDBJson() {
    return SavedPost(
      id: id,
      title: title,
      category: category,
      catId: catId,
      author: author,
      date: date,
      image: image,
      video: video,
    );
  }
}
