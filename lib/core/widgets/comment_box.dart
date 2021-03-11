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
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import '../entities/comment.dart';

class CommentBox extends StatelessWidget {
  final Comment comment;

  const CommentBox({
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).cardTheme.shadowColor!,
            blurRadius: 5,
            spreadRadius: -2,
          )
        ],
      ),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        color: Theme.of(context).cardTheme.color,
        child: Column(
          children: [
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(comment.avatar),
              ),
              title: Text(
                comment.author,
                style: Theme.of(context).primaryTextTheme.subtitle2,
              ),
              subtitle: Text(
                comment.date,
                style: Theme.of(context).primaryTextTheme.bodyText2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Html(
                data: comment.content,
                style: {
                  'p': Style.fromTextStyle(
                    Theme.of(context).textTheme.bodyText1!,
                  ),
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
