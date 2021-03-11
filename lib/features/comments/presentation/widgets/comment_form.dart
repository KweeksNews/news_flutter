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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../providers.dart';

class CommentForm extends StatefulWidget {
  final int postId;

  const CommentForm({
    required this.postId,
  });

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Center(
            child: Consumer(
              builder: (context, watch, child) {
                final identity = watch(identityProvider);

                return Text(
                  identity['name']!.isNotEmpty && identity['email']!.isNotEmpty
                      ? 'Kirim komentar sebagai\n$identity["name"] ($identity["email"])'
                      : 'Kamu belum mengatur identitas!',
                  style: Theme.of(context).primaryTextTheme.headline6,
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 55,
                      maxHeight: 55,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardTheme.shadowColor!,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: Theme.of(context).primaryTextTheme.headline4,
                      decoration: InputDecoration(
                        hintText: 'Tulis komentar',
                        hintStyle: Theme.of(context).primaryTextTheme.headline4,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tulis komentar!';
                        } else if (value.length > 300) {
                          return 'Batas komentar adalah 300 karakter!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        context.read(commentsProvider.notifier).comment = value!;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).cardTheme.shadowColor!,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Material(
                      color: Theme.of(context).accentColor,
                      child: InkWell(
                        splashColor: Theme.of(context).cardTheme.shadowColor,
                        // onTap: () => _sendComment(),
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.solidPaperPlane,
                              size: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
