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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/l10n/l10n.dart';
import '../widgets/locale_settings.dart';
import '../widgets/theme_settings.dart';

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).pageSettingsTitle,
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.adjust,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).settingThemeTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).settingThemeSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () {
                          showDialog<dynamic>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext dialogContext) {
                              return const ThemeSettingsDialog();
                            },
                          );
                        },
                      ),
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.language,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).settingLanguageTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).settingLanguageSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () {
                          showDialog<dynamic>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext dialogContext) {
                              return const LocaleSettingsDialog();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).menuSubmitContentTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)
                              .menuSubmitContentSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url =
                              'https://www.kweeksnews.com/send-content/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
                      ),
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.solidCommentDots,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).menuContactUsTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).menuContactUsSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url = 'https://www.kweeksnews.com/contact/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
                      ),
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.link,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).menuWebsiteTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).menuWebsiteSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url = 'https://www.kweeksnews.com/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.link,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).menuSchoolWebsiteTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)
                              .menuSchoolWebsiteSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url = 'https://muallimin.sch.id/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
                      ),
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.fileSignature,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context)
                              .menuNewStudentRegistrationTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)
                              .menuNewStudentRegistrationSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url = 'https://ppdb.muallimin.sch.id/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.infoCircle,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).menuAboutTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).menuAboutSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () {
                          //TODO add "about" information
                        },
                      ),
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.codeBranch,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).menuVersionTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: FutureBuilder<PackageInfo>(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.connectionState == ConnectionState.done
                                  ? AppLocalizations.of(context)
                                      .menuVersionSubtitle(
                                          snapshot.data!.version,
                                          snapshot.data!.buildNumber)
                                  : AppLocalizations.of(context).messageLoading,
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            );
                          },
                        ),
                      ),
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.shareAlt,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context).menuShareTitle,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).menuShareSubtitle,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () {
                          Share.share(
                            AppLocalizations.of(context).menuShareMessage,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
