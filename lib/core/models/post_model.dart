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

import '../databases/database_utils.dart';
import '../entities/author.dart';
import '../entities/category.dart';
import '../entities/post.dart';
import '../entities/tag.dart';
import 'author_model.dart';
import 'category_model.dart';
import 'tag_model.dart';

class PostModel extends Post {
  const PostModel({
    required int id,
    required DateTime date,
    required String slug,
    required String title,
    required String content,
    required String image,
    required String video,
    required Author author,
    required List<Category> categories,
    required List<Tag> tags,
  }) : super(
          id: id,
          date: date,
          slug: slug,
          title: title,
          content: content,
          image: image,
          video: video,
          author: author,
          categories: categories,
          tags: tags,
        );

  factory PostModel.fromGraphQLJson(
    Map<String, dynamic> data,
  ) {
    return PostModel(
      id: data['databaseId'] as int,
      date: DateTime.parse(data['date'] as String),
      slug: data['slug'] as String,
      title: HtmlUnescape().convert(data['title'] as String),
      content: data['content'] as String? ?? '',
      image: data['featuredImage']?['node']['sourceUrl'] as String? ?? '',
      video: data['featuredVideo'] as String,
      author: AuthorModel.fromGraphQlJson(
        data['author']['node'] as Map<String, dynamic>,
      ),
      categories: List.from(
        (data['categories']?['nodes'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>()
            .map(
              (Map<String, dynamic> d) => CategoryModel.fromGraphQlJson(d),
            ),
      ),
      tags: List.from(
        (data['tags']?['nodes'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>()
            .map(
              (Map<String, dynamic> d) => TagModel.fromGraphQlJson(d),
            ),
      ),
    );
  }

  factory PostModel.fromDB(
    SavedPost data,
  ) {
    return PostModel(
      id: data.id,
      date: data.date,
      slug: data.slug,
      title: data.title,
      content: '',
      image: data.image,
      video: data.video,
      author: data.author,
      categories: data.categories,
      tags: const [],
    );
  }

  SavedPost toDB() {
    return SavedPost(
      id: id,
      date: date,
      slug: slug,
      title: title,
      image: image,
      video: video,
      author: author,
      categories: categories,
    );
  }
}
