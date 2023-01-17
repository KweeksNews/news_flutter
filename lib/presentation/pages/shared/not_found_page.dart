// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/l10n.dart';
import 'widgets/error_indicator.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Center(
            child: ErrorIndicator(
              message: AppLocalizations.of(context).errorPageNotFound,
              image: 'assets/img/error.png',
              buttonText: AppLocalizations.of(context).buttonGoBack,
              onButtonPressed: () {
                context.pop();
              },
            ),
          ),
        ),
      ),
    );
  }
}
