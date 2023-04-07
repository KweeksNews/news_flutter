// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';

import '../../l10n/generated/l10n.dart';

class ErrorIndicator extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final String? message;
  final String? image;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const ErrorIndicator({
    super.key,
    this.margin,
    this.message,
    this.image,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      alignment: Alignment.center,
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            image ?? 'assets/img/error.png',
            width: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            message ?? AppLocalizations.of(context).errorGeneric,
            textAlign: TextAlign.center,
          ),
          if (onButtonPressed != null)
            TextButton.icon(
              icon: const Icon(
                Icons.refresh,
              ),
              label: Text(
                buttonText ?? AppLocalizations.of(context).buttonTryAgain,
              ),
              onPressed: onButtonPressed,
            ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
