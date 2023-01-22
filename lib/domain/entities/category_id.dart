// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class CategoryId extends Equatable {
  final String id;
  final String type;

  const CategoryId._(
    this.id,
    this.type,
  );

  factory CategoryId.databaseId(
    String id,
  ) {
    return CategoryId._(
      id,
      'DATABASE_ID',
    );
  }

  factory CategoryId.id(
    String id,
  ) {
    return CategoryId._(
      id,
      'ID',
    );
  }

  factory CategoryId.name(
    String id,
  ) {
    return CategoryId._(
      id,
      'NAME',
    );
  }

  factory CategoryId.slug(
    String id,
  ) {
    return CategoryId._(
      id,
      'SLUG',
    );
  }

  factory CategoryId.uri(
    String id,
  ) {
    return CategoryId._(
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
