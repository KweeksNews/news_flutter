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

class ErrorIndicator extends StatelessWidget {
  final VoidCallback? onTryAgain;
  final String? message;
  final String? image;

  const ErrorIndicator({
    this.onTryAgain,
    this.message,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
            message ?? 'Terjadi kesalahan.',
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          // ignore: prefer_if_elements_to_conditional_expressions
          if (onTryAgain != null)
            TextButton.icon(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Muat ulang',
                style: Theme.of(context).primaryTextTheme.headline5!.copyWith(
                      fontSize: 14,
                    ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                overlayColor: MaterialStateProperty.all(
                  Theme.of(context).cardTheme.shadowColor,
                ),
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
