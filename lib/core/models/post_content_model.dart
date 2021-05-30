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
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';

import '../entities/post_content.dart';

class PostContentModel extends PostContent {
  const PostContentModel({
    required int id,
    required String title,
    required String content,
    required String category,
    required int catId,
    required String author,
    required String avatar,
    required String date,
    required String image,
    required String video,
    required String link,
  }) : super(
          id: id,
          title: title,
          content: content,
          category: category,
          catId: catId,
          author: author,
          avatar: avatar,
          date: date,
          image: image,
          video: video,
          link: link,
        );

  factory PostContentModel.fromApiJson(Response response) {
    return PostContentModel(
      id: response.data['id'] as int,
      title:
          HtmlUnescape().convert(response.data['title']['rendered'] as String),
      content: response.data['content'] != null
          ? response.data['content']['rendered'] as String
          : '',
      category: response.data['custom']['categories']['name'] as String,
      catId: response.data['custom']['categories']['id'] as int,
      author: response.data['custom']['author']['name'] as String,
      avatar: response.data['custom']['author']['avatar'] as String,
      date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
          .format(DateTime.parse(response.data['date'] as String))
          .toString(),
      image: response.data['custom']['featured_image'] as String,
      video: response.data['custom']['video'] as String,
      link: response.data['link'] as String,
    );
  }
}
