// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class UserId extends Equatable {
  final String id;
  final String type;

  const UserId._(
    this.id,
    this.type,
  );

  factory UserId.databaseId(
    String id,
  ) {
    return UserId._(
      id,
      'DATABASE_ID',
    );
  }

  factory UserId.email(
    String id,
  ) {
    return UserId._(
      id,
      'EMAIL',
    );
  }

  factory UserId.id(
    String id,
  ) {
    return UserId._(
      id,
      'ID',
    );
  }

  factory UserId.slug(
    String id,
  ) {
    return UserId._(
      id,
      'SLUG',
    );
  }

  factory UserId.uri(
    String id,
  ) {
    return UserId._(
      id,
      'URI',
    );
  }

  factory UserId.username(
    String id,
  ) {
    return UserId._(
      id,
      'USERNAME',
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      type,
    ];
  }
}
