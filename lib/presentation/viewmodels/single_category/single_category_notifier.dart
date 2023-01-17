// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/single_category/get_category.dart';
import '../../../domain/enums/category_id_type.dart';
import 'notifier.dart';

@injectable
class SingleCategoryNotifier extends StateNotifier<SingleCategoryState> {
  final GetCategory _getCategory;

  SingleCategoryNotifier(
    this._getCategory,
  ) : super(const SingleCategoryState.loading());

  Future<void> fetchCategory({
    required String id,
    required CategoryIdType idType,
    bool forceRefresh = false,
  }) async {
    state = const SingleCategoryState.loading();

    final failureOrCategory = await _getCategory(
      id: id,
      idType: idType,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrCategory.fold(
        (failure) {
          state = const SingleCategoryState.failedToLoadData();
        },
        (categoryData) {
          state = SingleCategoryState.loaded(
            category: categoryData,
          );
        },
      );
    }
  }
}
