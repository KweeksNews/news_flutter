// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class NetworkFailure extends Failure {}

class RequestFailure extends Failure {}

class DatabaseFailure extends Failure {}

class ConfigFailure extends Failure {}
