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

import 'package:equatable/equatable.dart';

import 'author.dart';
import 'category.dart';

class Post extends Equatable {
  final int id;
  final DateTime date;
  final String slug;
  final String link;
  final String title;
  final String content;
  final String image;
  final String video;
  final List<Category> categories;
  final Author author;

  const Post({
    required this.id,
    required this.date,
    required this.slug,
    required this.link,
    required this.title,
    required this.content,
    required this.image,
    required this.video,
    required this.categories,
    required this.author,
  });

  @override
  List<Object> get props {
    return [
      id,
      date,
      slug,
      link,
      title,
      content,
      image,
      video,
      categories,
      author,
    ];
  }
}
