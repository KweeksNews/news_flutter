// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/single_user/get_user.dart';
import '../../../domain/entities/user_id.dart';
import 'notifier.dart';

@injectable
class SingleUserNotifier extends StateNotifier<SingleUserState> {
  final GetUser _getUser;

  SingleUserNotifier(
    this._getUser,
  ) : super(const SingleUserState.loading());

  Future<void> fetchUser({
    required UserId id,
    bool forceRefresh = false,
  }) async {
    state = const SingleUserState.loading();

    final failureOrUser = await _getUser(
      id: id,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrUser.fold(
        (failure) {
          state = const SingleUserState.failedToLoadData();
        },
        (userData) {
          state = SingleUserState.loaded(
            user: userData,
          );
        },
      );
    }
  }
}
