// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import '../../domain/entities/content_group_config.dart';
import '../../domain/entities/content_group_ids.dart';

class ContentGroupIdsModel extends ContentGroupIds {
  const ContentGroupIdsModel({
    required super.categoryIds,
    required super.tagIds,
  });

  factory ContentGroupIdsModel.fromContentGroupConfigList(
    List<ContentGroupConfig> configs,
  ) {
    List<String> categoryIds = [];
    List<String> tagIds = [];

    configs.map((d) {
      if (d is ContentGroupCategoryConfig) {
        categoryIds.add(d.id);
      } else if (d is ContentGroupTagConfig) {
        tagIds.add(d.id);
      }
    });

    return ContentGroupIdsModel(
      categoryIds: categoryIds,
      tagIds: tagIds,
    );
  }
}
