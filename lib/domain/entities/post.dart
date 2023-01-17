// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

import 'category.dart';
import 'tag.dart';
import 'user.dart';

class Post extends Equatable {
  final int id;
  final DateTime date;
  final String slug;
  final String title;
  final String content;
  final String image;
  final String video;
  final User author;
  final List<Category> categories;
  final List<Tag> tags;

  const Post({
    required this.id,
    required this.date,
    required this.slug,
    required this.title,
    required this.content,
    required this.image,
    required this.video,
    required this.author,
    required this.categories,
    required this.tags,
  });

  @override
  List<Object> get props {
    return [
      id,
      date,
      slug,
      title,
      content,
      image,
      video,
      author,
      categories,
      tags,
    ];
  }
}
