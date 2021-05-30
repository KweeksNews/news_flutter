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

class PostContent extends Equatable {
  final int id;
  final String title;
  final String content;
  final String category;
  final int catId;
  final String author;
  final String avatar;
  final String date;
  final String image;
  final String video;
  final String link;

  const PostContent({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.catId,
    required this.author,
    required this.avatar,
    required this.date,
    required this.image,
    required this.video,
    required this.link,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      content,
      category,
      catId,
      author,
      avatar,
      date,
      image,
      video,
      link,
    ];
  }
}
