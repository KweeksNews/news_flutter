// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final int id;
  final String slug;
  final String name;
  final String description;

  const Tag({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props {
    return [
      id,
      slug,
      name,
      description,
    ];
  }
}
