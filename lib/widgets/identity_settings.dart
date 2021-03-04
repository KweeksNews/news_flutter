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

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class IdentitySettingsDialog extends StatefulWidget {
  const IdentitySettingsDialog();

  @override
  _IdentitySettingsDialogState createState() => _IdentitySettingsDialogState();
}

class _IdentitySettingsDialogState extends State<IdentitySettingsDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _email;

  void _saveIdentity() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      context.read(identityProvider).setIdentity({
        'name': _name,
        'email': _email,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final Map<String, String> identity = watch(identityProvider.state);
      _name = identity['name'];
      _email = identity['email'];

      return SimpleDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        titlePadding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
        contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
        title: Center(
          child: Text(
            'Identitas',
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
        ),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: Theme.of(context).primaryTextTheme.headline4,
                  decoration: InputDecoration(
                    hintText: 'Nama',
                    hintStyle: Theme.of(context).primaryTextTheme.headline4,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    filled: true,
                    fillColor: Theme.of(context).canvasColor,
                  ),
                  initialValue: _name,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.words,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan nama!';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _name = value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).primaryTextTheme.headline4,
                  decoration: InputDecoration(
                    hintText: 'Alamat email',
                    hintStyle: Theme.of(context).primaryTextTheme.headline4,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    filled: true,
                    fillColor: Theme.of(context).canvasColor,
                  ),
                  initialValue: _email,
                  keyboardType: TextInputType.emailAddress,
                  textAlignVertical: TextAlignVertical.center,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return 'Masukkan alamat email yang valid!';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _email = value;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Material(
                color: Theme.of(context).accentColor,
                child: InkWell(
                  splashColor: Theme.of(context).cardTheme.shadowColor,
                  highlightColor: Theme.of(context).cardTheme.shadowColor,
                  onTap: () => _saveIdentity(),
                  child: SizedBox(
                    height: 35,
                    width: 70,
                    child: Center(
                      child: Icon(
                        Icons.done_rounded,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
