// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class PostId extends Equatable {
  final String id;
  final String type;

  const PostId._(
    this.id,
    this.type,
  );

  factory PostId.databaseId(
    String id,
  ) {
    return PostId._(
      id,
      'DATABASE_ID',
    );
  }

  factory PostId.id(
    String id,
  ) {
    return PostId._(
      id,
      'ID',
    );
  }

  factory PostId.slug(
    String id,
  ) {
    return PostId._(
      id,
      'SLUG',
    );
  }

  factory PostId.uri(
    String id,
  ) {
    return PostId._(
      id,
      'URI',
    );
  }

  @override
  List<Object?> get props => [id, type];
}
