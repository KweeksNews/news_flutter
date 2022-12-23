/* 
 * Copyright (C) 2021  Ahmad Rulim
 * 
 * This file is part of Flutter WordPress.
 * 
 * Flutter WordPress is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Flutter WordPress is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Flutter WordPress.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * @license GPL-3.0-or-later <https://spdx.org/licenses/GPL-3.0-or-later.html>
 */

import 'package:flutter/material.dart';

import '../l10n/generated/l10n.dart';

class ErrorIndicator extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final String? message;
  final String? image;
  final VoidCallback? onTryAgain;

  const ErrorIndicator({
    super.key,
    this.margin,
    this.message,
    this.image,
    this.onTryAgain,
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
          if (onTryAgain != null)
            TextButton.icon(
              icon: const Icon(
                Icons.refresh,
              ),
              label: Text(
                AppLocalizations.of(context).buttonTryAgain,
              ),
              onPressed: onTryAgain,
            ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
