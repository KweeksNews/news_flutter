// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(hours) => "A day";

  static String m1(minutes) => "A minute";

  static String m2(days) => "A month";

  static String m3(year) => "A year";

  static String m4(minutes) => "An hour";

  static String m5(days) => "${days} days";

  static String m6(date) => "${date}";

  static String m7(hours) => "${hours} hours";

  static String m8(seconds) => "A moment";

  static String m9(minutes) => "${minutes} minutes";

  static String m10(months) => "${months} months";

  static String m11(years) => "${years} years";

  static String m12(versionName, versionCode) =>
      "v${versionName}+${versionCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("KweeksNews"),
        "buttonTryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
        "dateADayText": m0,
        "dateAboutAMinuteText": m1,
        "dateAboutAMonthText": m2,
        "dateAboutAYearText": m3,
        "dateAboutAnHourText": m4,
        "dateAgoPrefix": MessageLookupByLibrary.simpleMessage(""),
        "dateAgoSuffix": MessageLookupByLibrary.simpleMessage("ago"),
        "dateDaysText": m5,
        "dateFormat": m6,
        "dateFromNowPrefix": MessageLookupByLibrary.simpleMessage(""),
        "dateFromNowSuffix": MessageLookupByLibrary.simpleMessage("from now"),
        "dateHoursText": m7,
        "dateLessThanOneMinuteText": m8,
        "dateMinutesText": m9,
        "dateMonthsText": m10,
        "dateWordSeparator": MessageLookupByLibrary.simpleMessage(" "),
        "dateYearsText": m11,
        "errorFailedToLoadData":
            MessageLookupByLibrary.simpleMessage("Failed to load data."),
        "errorGeneric":
            MessageLookupByLibrary.simpleMessage("An error occurred."),
        "errorNoPosts": MessageLookupByLibrary.simpleMessage("No posts yet."),
        "errorNoSavedPosts": MessageLookupByLibrary.simpleMessage(
            "There are no saved posts yet.\nStart saving!"),
        "errorNoSearchResult": MessageLookupByLibrary.simpleMessage(
            "No results.\nPlease try another keyword!"),
        "errorNoSearchTerm": MessageLookupByLibrary.simpleMessage(
            "Enter a keyword and start exploring!"),
        "menuAboutSubtitle": MessageLookupByLibrary.simpleMessage(
            "Information about KweeksNews"),
        "menuAboutTitle": MessageLookupByLibrary.simpleMessage("About"),
        "menuContactUsSubtitle":
            MessageLookupByLibrary.simpleMessage("redaksi@kweeksnews.com"),
        "menuContactUsTitle":
            MessageLookupByLibrary.simpleMessage("Contact us"),
        "menuNewStudentRegistrationSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "https://ppdb.muallimin.sch.id/"),
        "menuNewStudentRegistrationTitle":
            MessageLookupByLibrary.simpleMessage("PPDB information"),
        "menuSchoolWebsiteSubtitle":
            MessageLookupByLibrary.simpleMessage("https://muallimin.sch.id/"),
        "menuSchoolWebsiteTitle":
            MessageLookupByLibrary.simpleMessage("School website"),
        "menuShareMessage": MessageLookupByLibrary.simpleMessage(
            "Download the KweeksNews app now!\nhttps://go.kweeksnews.com/app"),
        "menuShareSubtitle":
            MessageLookupByLibrary.simpleMessage("Invite friends to download"),
        "menuShareTitle": MessageLookupByLibrary.simpleMessage("Share"),
        "menuSubmitContentSubtitle": MessageLookupByLibrary.simpleMessage(
            "Change the world with your creations!"),
        "menuSubmitContentTitle":
            MessageLookupByLibrary.simpleMessage("Submit content"),
        "menuVersionSubtitle": m12,
        "menuVersionTitle": MessageLookupByLibrary.simpleMessage("Version"),
        "menuWebsiteSubtitle":
            MessageLookupByLibrary.simpleMessage("https://www.kweeksnews.com/"),
        "menuWebsiteTitle": MessageLookupByLibrary.simpleMessage("Website"),
        "messageLoading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "navBarHomeLabel": MessageLookupByLibrary.simpleMessage("Home"),
        "navBarSavedPostsLabel":
            MessageLookupByLibrary.simpleMessage("Saved Posts"),
        "navBarSearchLabel": MessageLookupByLibrary.simpleMessage("Search"),
        "navBarSettingsLabel": MessageLookupByLibrary.simpleMessage("Settings"),
        "optionThemeDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "optionThemeLight": MessageLookupByLibrary.simpleMessage("Light"),
        "optionThemeSystem":
            MessageLookupByLibrary.simpleMessage("System default"),
        "pageContactTitle": MessageLookupByLibrary.simpleMessage("Contact"),
        "pageHomeTitle": MessageLookupByLibrary.simpleMessage("Home"),
        "pageSavedPostsTitle":
            MessageLookupByLibrary.simpleMessage("Saved Posts"),
        "pageSearchTitle": MessageLookupByLibrary.simpleMessage("Search"),
        "pageSettingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "pageSubmitContentTitle":
            MessageLookupByLibrary.simpleMessage("Submit Content"),
        "searchPlaceholderText":
            MessageLookupByLibrary.simpleMessage("Enter a keyword"),
        "settingLanguageSubtitle":
            MessageLookupByLibrary.simpleMessage("App display language"),
        "settingLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settingThemeSubtitle": MessageLookupByLibrary.simpleMessage(
            "Light, dark, or system default"),
        "settingThemeTitle": MessageLookupByLibrary.simpleMessage("Theme"),
        "widgetRelatedPostsTitle":
            MessageLookupByLibrary.simpleMessage("Related Posts")
      };
}
