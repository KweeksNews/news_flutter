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
import 'package:html_unescape/html_unescape.dart';

import '../entities/post.dart';

class PostBox extends StatelessWidget {
  final Post post;

  const PostBox({
    required this.post,
  });

  String get _postTitle {
    return HtmlUnescape().convert(post.title);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 155,
        maxHeight: 155,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).cardTheme.shadowColor!,
                  blurRadius: 5,
                )
              ],
            ),
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
            child: Card(
              color: Theme.of(context).cardTheme.color,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(115, 10, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _postTitle.length > 40
                            ? '${_postTitle.substring(0, 40)}...'
                            : _postTitle,
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            post.category,
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.date_range_rounded,
                              color: Color(0xFF999999),
                              size: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              post.date,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: SizedBox(
              height: 125,
              width: 125,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).cardTheme.shadowColor!,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Card(
                  color: Theme.of(context).cardTheme.color,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/placeholder.png'),
                      image: NetworkImage(post.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ignore: prefer_if_elements_to_conditional_expressions
          post.video
              ? Positioned(
                  left: 40,
                  top: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardTheme.shadowColor!,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.play_circle_outline_rounded,
                      color: Color(0xFFF44336),
                      size: 45,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
