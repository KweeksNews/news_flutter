// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class ContentGroupConfig extends Equatable {
  final String name;
  final String? _categoryId;
  final String? _tagId;

  const ContentGroupConfig._(
    this.name,
    this._categoryId,
    this._tagId,
  );

  factory ContentGroupConfig.category({
    required String name,
    required String id,
  }) {
    return ContentGroupCategoryConfig._(
      name,
      id,
    );
  }

  factory ContentGroupConfig.tag({
    required String name,
    required String id,
  }) {
    return ContentGroupTagConfig._(
      name,
      id,
    );
  }

  String get id {
    return (_categoryId ?? _tagId)!;
  }

  @override
  List<Object> get props {
    return [
      name,
    ];
  }
}

class ContentGroupCategoryConfig extends ContentGroupConfig {
  const ContentGroupCategoryConfig._(
    String name,
    String id,
  ) : super._(
          name,
          id,
          null,
        );
}

class ContentGroupTagConfig extends ContentGroupConfig {
  const ContentGroupTagConfig._(
    String name,
    String id,
  ) : super._(
          name,
          null,
          id,
        );
}
