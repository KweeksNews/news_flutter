// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `KweeksNews`
  String get appName {
    return Intl.message(
      'KweeksNews',
      name: 'appName',
      desc: 'The title of the application.',
      args: [],
    );
  }

  /// `{date}`
  String dateFormat(DateTime date) {
    final DateFormat dateDateFormat =
        DateFormat('dd MMMM yyyy, HH:mm', Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      '$dateString',
      name: 'dateFormat',
      desc: 'The date format.',
      args: [dateString],
    );
  }

  /// ``
  String get dateAgoPrefix {
    return Intl.message(
      '',
      name: 'dateAgoPrefix',
      desc: 'The prefix for the date ago.',
      args: [],
    );
  }

  /// ``
  String get dateFromNowPrefix {
    return Intl.message(
      '',
      name: 'dateFromNowPrefix',
      desc: 'The prefix for the date from now.',
      args: [],
    );
  }

  /// `ago`
  String get dateAgoSuffix {
    return Intl.message(
      'ago',
      name: 'dateAgoSuffix',
      desc: 'The suffix for the date ago.',
      args: [],
    );
  }

  /// `from now`
  String get dateFromNowSuffix {
    return Intl.message(
      'from now',
      name: 'dateFromNowSuffix',
      desc: 'The suffix for the date from now.',
      args: [],
    );
  }

  /// `A moment`
  String dateLessThanOneMinuteText(int seconds) {
    return Intl.message(
      'A moment',
      name: 'dateLessThanOneMinuteText',
      desc:
          'The text to display when the time difference is less than a minute.',
      args: [seconds],
    );
  }

  /// `A minute`
  String dateAboutAMinuteText(int minutes) {
    return Intl.message(
      'A minute',
      name: 'dateAboutAMinuteText',
      desc: 'The text to display when the time difference is about a minute.',
      args: [minutes],
    );
  }

  /// `{minutes} minutes`
  String dateMinutesText(int minutes) {
    return Intl.message(
      '$minutes minutes',
      name: 'dateMinutesText',
      desc: 'The text to display when the time difference is several minutes.',
      args: [minutes],
    );
  }

  /// `An hour`
  String dateAboutAnHourText(int minutes) {
    return Intl.message(
      'An hour',
      name: 'dateAboutAnHourText',
      desc: 'The text to display when the time difference is about an hour.',
      args: [minutes],
    );
  }

  /// `{hours} hours`
  String dateHoursText(int hours) {
    return Intl.message(
      '$hours hours',
      name: 'dateHoursText',
      desc: 'The text to display when the time difference is several hours.',
      args: [hours],
    );
  }

  /// `A day`
  String dateADayText(int hours) {
    return Intl.message(
      'A day',
      name: 'dateADayText',
      desc: 'The text to display when the time difference is a day.',
      args: [hours],
    );
  }

  /// `{days} days`
  String dateDaysText(int days) {
    return Intl.message(
      '$days days',
      name: 'dateDaysText',
      desc: 'The text to display when the time difference is several days.',
      args: [days],
    );
  }

  /// `A month`
  String dateAboutAMonthText(int days) {
    return Intl.message(
      'A month',
      name: 'dateAboutAMonthText',
      desc: 'The text to display when the time difference is about a month.',
      args: [days],
    );
  }

  /// `{months} months`
  String dateMonthsText(int months) {
    return Intl.message(
      '$months months',
      name: 'dateMonthsText',
      desc: 'The text to display when the time difference is several months.',
      args: [months],
    );
  }

  /// `A year`
  String dateAboutAYearText(int year) {
    return Intl.message(
      'A year',
      name: 'dateAboutAYearText',
      desc: 'The text to display when the time difference is about a year.',
      args: [year],
    );
  }

  /// `{years} years`
  String dateYearsText(int years) {
    return Intl.message(
      '$years years',
      name: 'dateYearsText',
      desc: 'The text to display when the time difference is several years.',
      args: [years],
    );
  }

  /// ` `
  String get dateWordSeparator {
    return Intl.message(
      ' ',
      name: 'dateWordSeparator',
      desc: 'The separator between the date words.',
      args: [],
    );
  }

  /// `Home`
  String get navBarHomeLabel {
    return Intl.message(
      'Home',
      name: 'navBarHomeLabel',
      desc: 'The label of the home button in the navigation bar.',
      args: [],
    );
  }

  /// `Search`
  String get navBarSearchLabel {
    return Intl.message(
      'Search',
      name: 'navBarSearchLabel',
      desc: 'The label of the search button in the navigation bar.',
      args: [],
    );
  }

  /// `Saved Posts`
  String get navBarSavedPostsLabel {
    return Intl.message(
      'Saved Posts',
      name: 'navBarSavedPostsLabel',
      desc: 'The label of the saved posts button in the navigation bar.',
      args: [],
    );
  }

  /// `Settings`
  String get navBarSettingsLabel {
    return Intl.message(
      'Settings',
      name: 'navBarSettingsLabel',
      desc: 'The label of the settings button in the navigation bar.',
      args: [],
    );
  }

  /// `Try again`
  String get buttonTryAgain {
    return Intl.message(
      'Try again',
      name: 'buttonTryAgain',
      desc: 'The text of the try again button.',
      args: [],
    );
  }

  /// `Loading...`
  String get messageLoading {
    return Intl.message(
      'Loading...',
      name: 'messageLoading',
      desc: 'The text of the loading state message.',
      args: [],
    );
  }

  /// `An error occurred.`
  String get errorGeneric {
    return Intl.message(
      'An error occurred.',
      name: 'errorGeneric',
      desc: 'The message of the generic error.',
      args: [],
    );
  }

  /// `No posts yet.`
  String get errorNoPosts {
    return Intl.message(
      'No posts yet.',
      name: 'errorNoPosts',
      desc: 'The message of the no posts error.',
      args: [],
    );
  }

  /// `There are no saved posts yet.\nStart saving!`
  String get errorNoSavedPosts {
    return Intl.message(
      'There are no saved posts yet.\nStart saving!',
      name: 'errorNoSavedPosts',
      desc: 'The message of the no saved posts error.',
      args: [],
    );
  }

  /// `Enter a keyword and start exploring!`
  String get errorNoSearchTerm {
    return Intl.message(
      'Enter a keyword and start exploring!',
      name: 'errorNoSearchTerm',
      desc: 'The message of the no search term error.',
      args: [],
    );
  }

  /// `No results.\nPlease try another keyword!`
  String get errorNoSearchResult {
    return Intl.message(
      'No results.\nPlease try another keyword!',
      name: 'errorNoSearchResult',
      desc: 'The message of the no search result error.',
      args: [],
    );
  }

  /// `Failed to load data.`
  String get errorFailedToLoadData {
    return Intl.message(
      'Failed to load data.',
      name: 'errorFailedToLoadData',
      desc: 'The message of the failed to load data error.',
      args: [],
    );
  }

  /// `Cannot open {url}.`
  String errorCannotOpenUrl(String url) {
    return Intl.message(
      'Cannot open $url.',
      name: 'errorCannotOpenUrl',
      desc: 'The message of the cannot open URL error.',
      args: [url],
    );
  }

  /// `Home`
  String get pageHomeTitle {
    return Intl.message(
      'Home',
      name: 'pageHomeTitle',
      desc: 'The title of the home page.',
      args: [],
    );
  }

  /// `Search`
  String get pageSearchTitle {
    return Intl.message(
      'Search',
      name: 'pageSearchTitle',
      desc: 'The title of the search page.',
      args: [],
    );
  }

  /// `Enter a keyword`
  String get searchPlaceholderText {
    return Intl.message(
      'Enter a keyword',
      name: 'searchPlaceholderText',
      desc: 'The placeholder text of the search input.',
      args: [],
    );
  }

  /// `Saved Posts`
  String get pageSavedPostsTitle {
    return Intl.message(
      'Saved Posts',
      name: 'pageSavedPostsTitle',
      desc: 'The title of the saved posts page.',
      args: [],
    );
  }

  /// `Settings`
  String get pageSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'pageSettingsTitle',
      desc: 'The title of the saved settings page.',
      args: [],
    );
  }

  /// `Theme`
  String get settingThemeTitle {
    return Intl.message(
      'Theme',
      name: 'settingThemeTitle',
      desc: 'The title of the theme setting.',
      args: [],
    );
  }

  /// `Light, dark, or system default`
  String get settingThemeSubtitle {
    return Intl.message(
      'Light, dark, or system default',
      name: 'settingThemeSubtitle',
      desc: 'The subtitle of the theme setting.',
      args: [],
    );
  }

  /// `Light`
  String get optionThemeLight {
    return Intl.message(
      'Light',
      name: 'optionThemeLight',
      desc: 'The text of the light theme option.',
      args: [],
    );
  }

  /// `Dark`
  String get optionThemeDark {
    return Intl.message(
      'Dark',
      name: 'optionThemeDark',
      desc: 'The text of the dark theme option.',
      args: [],
    );
  }

  /// `System default`
  String get optionThemeSystem {
    return Intl.message(
      'System default',
      name: 'optionThemeSystem',
      desc: 'The text of the system default theme option.',
      args: [],
    );
  }

  /// `Language`
  String get settingLanguageTitle {
    return Intl.message(
      'Language',
      name: 'settingLanguageTitle',
      desc: 'The title of the language setting.',
      args: [],
    );
  }

  /// `App display language`
  String get settingLanguageSubtitle {
    return Intl.message(
      'App display language',
      name: 'settingLanguageSubtitle',
      desc: 'The subtitle of the language setting.',
      args: [],
    );
  }

  /// `Submit content`
  String get menuSubmitContentTitle {
    return Intl.message(
      'Submit content',
      name: 'menuSubmitContentTitle',
      desc: 'The title of the submit content menu.',
      args: [],
    );
  }

  /// `Change the world with your creations!`
  String get menuSubmitContentSubtitle {
    return Intl.message(
      'Change the world with your creations!',
      name: 'menuSubmitContentSubtitle',
      desc: 'The subtitle of the submit content menu.',
      args: [],
    );
  }

  /// `Contact us`
  String get menuContactUsTitle {
    return Intl.message(
      'Contact us',
      name: 'menuContactUsTitle',
      desc: 'The title of the contact us menu.',
      args: [],
    );
  }

  /// `redaksi@kweeksnews.com`
  String get menuContactUsSubtitle {
    return Intl.message(
      'redaksi@kweeksnews.com',
      name: 'menuContactUsSubtitle',
      desc: 'The subtitle of the contact us menu.',
      args: [],
    );
  }

  /// `Website`
  String get menuWebsiteTitle {
    return Intl.message(
      'Website',
      name: 'menuWebsiteTitle',
      desc: 'The title of the website menu.',
      args: [],
    );
  }

  /// `https://www.kweeksnews.com`
  String get menuWebsiteSubtitle {
    return Intl.message(
      'https://www.kweeksnews.com',
      name: 'menuWebsiteSubtitle',
      desc: 'The subtitle of the website menu.',
      args: [],
    );
  }

  /// `School website`
  String get menuSchoolWebsiteTitle {
    return Intl.message(
      'School website',
      name: 'menuSchoolWebsiteTitle',
      desc: 'The title of the school website menu.',
      args: [],
    );
  }

  /// `https://muallimin.sch.id`
  String get menuSchoolWebsiteSubtitle {
    return Intl.message(
      'https://muallimin.sch.id',
      name: 'menuSchoolWebsiteSubtitle',
      desc: 'The subtitle of the school website menu.',
      args: [],
    );
  }

  /// `PPDB information`
  String get menuNewStudentRegistrationTitle {
    return Intl.message(
      'PPDB information',
      name: 'menuNewStudentRegistrationTitle',
      desc: 'The title of the new student registration menu.',
      args: [],
    );
  }

  /// `https://ppdb.muallimin.sch.id`
  String get menuNewStudentRegistrationSubtitle {
    return Intl.message(
      'https://ppdb.muallimin.sch.id',
      name: 'menuNewStudentRegistrationSubtitle',
      desc: 'The subtitle of the new student registration menu.',
      args: [],
    );
  }

  /// `About`
  String get menuAboutTitle {
    return Intl.message(
      'About',
      name: 'menuAboutTitle',
      desc: 'The title of the about menu.',
      args: [],
    );
  }

  /// `Information about KweeksNews`
  String get menuAboutSubtitle {
    return Intl.message(
      'Information about KweeksNews',
      name: 'menuAboutSubtitle',
      desc: 'The subtitle of the about menu.',
      args: [],
    );
  }

  /// `Version`
  String get menuVersionTitle {
    return Intl.message(
      'Version',
      name: 'menuVersionTitle',
      desc: 'The title of the version menu.',
      args: [],
    );
  }

  /// `v{versionName}+{versionCode}`
  String menuVersionSubtitle(String versionName, String versionCode) {
    return Intl.message(
      'v$versionName+$versionCode',
      name: 'menuVersionSubtitle',
      desc: 'The subtitle of the version menu.',
      args: [versionName, versionCode],
    );
  }

  /// `Share`
  String get menuShareTitle {
    return Intl.message(
      'Share',
      name: 'menuShareTitle',
      desc: 'The title of the share menu.',
      args: [],
    );
  }

  /// `Invite friends to download`
  String get menuShareSubtitle {
    return Intl.message(
      'Invite friends to download',
      name: 'menuShareSubtitle',
      desc: 'The subtitle of the share menu.',
      args: [],
    );
  }

  /// `Download the KweeksNews app now!\nhttps://go.kweeksnews.com/app`
  String get menuShareMessage {
    return Intl.message(
      'Download the KweeksNews app now!\nhttps://go.kweeksnews.com/app',
      name: 'menuShareMessage',
      desc: 'The message of the share menu.',
      args: [],
    );
  }

  /// `Related Posts`
  String get widgetRelatedPostsTitle {
    return Intl.message(
      'Related Posts',
      name: 'widgetRelatedPostsTitle',
      desc: 'The title of the related posts widget.',
      args: [],
    );
  }

  /// `Contact`
  String get pageContactTitle {
    return Intl.message(
      'Contact',
      name: 'pageContactTitle',
      desc: 'The title of the contact page.',
      args: [],
    );
  }

  /// `Submit Content`
  String get pageSubmitContentTitle {
    return Intl.message(
      'Submit Content',
      name: 'pageSubmitContentTitle',
      desc: 'The title of the submit content page.',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'id'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
