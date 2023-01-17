// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

class StateException extends Equatable {
  final String message;
  final String image;

  const StateException({
    required this.message,
    required this.image,
  });

  @override
  List<Object?> get props {
    return [
      message,
      image,
    ];
  }
}
