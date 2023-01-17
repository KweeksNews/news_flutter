// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:timeago/timeago.dart';

import 'generated/l10n.dart';

class TimeagoLocalization implements LookupMessages {
  @override
  String prefixAgo() {
    return AppLocalizations.current.dateAgoPrefix;
  }

  @override
  String prefixFromNow() {
    return AppLocalizations.current.dateFromNowPrefix;
  }

  @override
  String suffixAgo() {
    return AppLocalizations.current.dateAgoSuffix;
  }

  @override
  String suffixFromNow() {
    return AppLocalizations.current.dateFromNowSuffix;
  }

  @override
  String lessThanOneMinute(
    int seconds,
  ) {
    return AppLocalizations.current.dateLessThanOneMinuteText(seconds);
  }

  @override
  String aboutAMinute(
    int minutes,
  ) {
    return AppLocalizations.current.dateAboutAMinuteText(minutes);
  }

  @override
  String minutes(
    int minutes,
  ) {
    return AppLocalizations.current.dateMinutesText(minutes);
  }

  @override
  String aboutAnHour(
    int minutes,
  ) {
    return AppLocalizations.current.dateAboutAnHourText(minutes);
  }

  @override
  String hours(
    int hours,
  ) {
    return AppLocalizations.current.dateHoursText(hours);
  }

  @override
  String aDay(
    int hours,
  ) {
    return AppLocalizations.current.dateADayText(hours);
  }

  @override
  String days(
    int days,
  ) {
    return AppLocalizations.current.dateDaysText(days);
  }

  @override
  String aboutAMonth(
    int days,
  ) {
    return AppLocalizations.current.dateAboutAMonthText(days);
  }

  @override
  String months(
    int months,
  ) {
    return AppLocalizations.current.dateMonthsText(months);
  }

  @override
  String aboutAYear(
    int year,
  ) {
    return AppLocalizations.current.dateAboutAYearText(year);
  }

  @override
  String years(
    int years,
  ) {
    return AppLocalizations.current.dateYearsText(years);
  }

  @override
  String wordSeparator() {
    return AppLocalizations.current.dateWordSeparator;
  }
}
