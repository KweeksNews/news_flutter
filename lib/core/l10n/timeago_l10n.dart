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
