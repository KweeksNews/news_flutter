// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class TagId extends Equatable {
  final String id;
  final String type;

  const TagId._(
    this.id,
    this.type,
  );

  factory TagId.databaseId(
    String id,
  ) {
    return TagId._(
      id,
      'DATABASE_ID',
    );
  }

  factory TagId.id(
    String id,
  ) {
    return TagId._(
      id,
      'ID',
    );
  }

  factory TagId.name(
    String id,
  ) {
    return TagId._(
      id,
      'NAME',
    );
  }

  factory TagId.slug(
    String id,
  ) {
    return TagId._(
      id,
      'SLUG',
    );
  }

  factory TagId.uri(
    String id,
  ) {
    return TagId._(
      id,
      'URI',
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      type,
    ];
  }
}
