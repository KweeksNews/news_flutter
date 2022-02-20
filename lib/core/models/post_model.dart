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

import '../databases/database_utils.dart';
import '../entities/author.dart';
import '../entities/category.dart';
import '../entities/post.dart';
import 'author_model.dart';
import 'category_model.dart';

class PostModel extends Post {
  const PostModel({
    required int id,
    required DateTime date,
    required String slug,
    required String link,
    required String title,
    required String content,
    required String image,
    required String video,
    required List<Category> categories,
    required Author author,
  }) : super(
          id: id,
          date: date,
          slug: slug,
          link: link,
          title: title,
          content: content,
          image: image,
          video: video,
          categories: categories,
          author: author,
        );

  factory PostModel.fromApiResponse(Response<dynamic> response) {
    return PostModel(
      id: int.parse(response.data[0]['id'].toString()),
      date: DateTime.parse(response.data[0]['date'].toString()),
      slug: response.data[0]['slug'].toString(),
      link: response.data[0]['link'].toString(),
      title: HtmlUnescape().convert(
        response.data[0]['title']['rendered'].toString(),
      ),
      content: response.data[0]['content']['rendered'].toString(),
      image: response.data[0]['meta_for_app']['featured_image'].toString(),
      video: response.data[0]['meta_for_app']['video'].toString(),
      categories: List.from(
        (response.data[0]['meta_for_app']['categories'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(
              (Map<String, dynamic> d) => CategoryModel.fromJson(d),
            ),
      ),
      author: AuthorModel.fromJson(
        response.data[0]['meta_for_app']['author'] as Map<String, dynamic>,
      ),
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: int.parse(json['id'].toString()),
      date: DateTime.parse(json['date'].toString()),
      slug: json['slug'].toString(),
      link: json['link'].toString(),
      title: HtmlUnescape().convert(json['title']['rendered'].toString()),
      content: json['content']?['rendered'] != null
          ? json['content']['rendered'].toString()
          : '',
      image: json['meta_for_app']['featured_image'].toString(),
      video: json['meta_for_app']['video'].toString(),
      categories: List.from(
        (json['meta_for_app']['categories'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(
              (Map<String, dynamic> d) => CategoryModel.fromJson(d),
            ),
      ),
      author: AuthorModel.fromJson(
        json['meta_for_app']['author'] as Map<String, dynamic>,
      ),
    );
  }

  factory PostModel.fromDBJson(SavedPost data) {
    return PostModel(
      id: data.id,
      date: data.date,
      slug: data.slug,
      link: data.link,
      title: data.title,
      content: '',
      image: data.image,
      video: data.video,
      categories: data.categories,
      author: data.author,
    );
  }

  SavedPost toDBJson() {
    return SavedPost(
      id: id,
      date: date,
      slug: slug,
      link: link,
      title: title,
      image: image,
      video: video,
      categories: categories,
      author: author,
    );
  }
}
