// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class ContentGroupIds extends Equatable {
  final List<String>? categoryIds;
  final List<String>? tagIds;

  const ContentGroupIds({
    this.categoryIds,
    this.tagIds,
  });

  factory ContentGroupIds.category(
    List<String> ids,
  ) {
    return ContentGroupIds(
      categoryIds: ids,
      tagIds: null,
    );
  }

  factory ContentGroupIds.tag(
    List<String> ids,
  ) {
    return ContentGroupIds(
      categoryIds: null,
      tagIds: ids,
    );
  }

  @override
  List<Object?> get props {
    return [
      categoryIds,
      tagIds,
    ];
  }
}
