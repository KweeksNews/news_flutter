// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/generated/l10n.dart';
import '../../widgets/settings/locale_settings.dart';
import '../../widgets/settings/theme_settings.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              centerTitle: true,
              elevation: 0,
              title: Text(
                AppLocalizations.of(context).pageSettingsTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.only(left: 15, right: 15),
            children: <Widget>[
              Card(
                margin: const EdgeInsets.only(top: 15),
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
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.circleHalfStroke,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).settingThemeTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).settingThemeSubtitle,
                      ),
                      onTap: () {
                        showDialog<dynamic>(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
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
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.language,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).settingLanguageTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).settingLanguageSubtitle,
                      ),
                      onTap: () {
                        showDialog<dynamic>(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return const LocaleSettingsDialog();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.only(top: 15),
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
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).menuSubmitContentTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).menuSubmitContentSubtitle,
                      ),
                      onTap: () {
                        context.push('/submit-content');
                      },
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.solidCommentDots,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).menuContactUsTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).menuContactUsSubtitle,
                      ),
                      onTap: () {
                        context.push('/contact');
                      },
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.link,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).menuWebsiteTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).menuWebsiteSubtitle,
                      ),
                      onTap: () async {
                        const url = 'https://www.kweeksnews.com';

                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)
                                    .errorCannotOpenUrl(url),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.only(top: 15),
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
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.link,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).menuSchoolWebsiteTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).menuSchoolWebsiteSubtitle,
                      ),
                      onTap: () async {
                        const url = 'https://muallimin.sch.id';

                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)
                                    .errorCannotOpenUrl(url),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.fileSignature,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context)
                            .menuNewStudentRegistrationTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context)
                            .menuNewStudentRegistrationSubtitle,
                      ),
                      onTap: () async {
                        const url = 'https://ppdb.muallimin.sch.id';

                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)
                                    .errorCannotOpenUrl(url),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.only(top: 15, bottom: 15),
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
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.shareNodes,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).menuShareTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).menuShareSubtitle,
                      ),
                      onTap: () {
                        Share.share(
                          AppLocalizations.of(context).menuShareMessage,
                        );
                      },
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.circleInfo,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).menuAboutTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).menuAboutSubtitle,
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
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      leading: Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.codeBranch,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context).menuVersionTitle,
                      ),
                      subtitle: FutureBuilder<PackageInfo>(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.connectionState == ConnectionState.done
                                ? AppLocalizations.of(context)
                                    .menuVersionSubtitle(snapshot.data!.version,
                                        snapshot.data!.buildNumber)
                                : AppLocalizations.of(context).messageLoading,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
