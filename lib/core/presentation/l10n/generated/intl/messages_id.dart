// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  String get localeName => 'id';

  static String m0(hours) => "sehari";

  static String m1(minutes) => "Semenit";

  static String m2(days) => "Sebulan";

  static String m3(year) => "Setahun";

  static String m4(minutes) => "Sejam";

  static String m5(days) => "${days} hari";

  static String m6(date) => "${date}";

  static String m7(hours) => "${hours} jam";

  static String m8(seconds) => "Beberapa saat";

  static String m9(minutes) => "${minutes} menit";

  static String m10(months) => "${months} bulan";

  static String m11(years) => "${years} tahun";

  static String m12(url) => "Tidak bisa membuka ${url}.";

  static String m13(versionName, versionCode) =>
      "v${versionName}+${versionCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("KweeksNews"),
        "buttonTryAgain": MessageLookupByLibrary.simpleMessage("Coba lagi"),
        "dateADayText": m0,
        "dateAboutAMinuteText": m1,
        "dateAboutAMonthText": m2,
        "dateAboutAYearText": m3,
        "dateAboutAnHourText": m4,
        "dateAgoPrefix": MessageLookupByLibrary.simpleMessage(""),
        "dateAgoSuffix": MessageLookupByLibrary.simpleMessage("yang lalu"),
        "dateDaysText": m5,
        "dateFormat": m6,
        "dateFromNowPrefix": MessageLookupByLibrary.simpleMessage(""),
        "dateFromNowSuffix":
            MessageLookupByLibrary.simpleMessage("dari sekarang"),
        "dateHoursText": m7,
        "dateLessThanOneMinuteText": m8,
        "dateMinutesText": m9,
        "dateMonthsText": m10,
        "dateWordSeparator": MessageLookupByLibrary.simpleMessage(" "),
        "dateYearsText": m11,
        "errorCannotOpenUrl": m12,
        "errorFailedToChangeLanguage":
            MessageLookupByLibrary.simpleMessage("Gagal mengganti bahasa."),
        "errorFailedToChangeTheme":
            MessageLookupByLibrary.simpleMessage("Gagal mengganti tema."),
        "errorFailedToLoadData":
            MessageLookupByLibrary.simpleMessage("Gagal memuat data."),
        "errorNoPosts":
            MessageLookupByLibrary.simpleMessage("Belum ada kiriman."),
        "errorNoSavedPosts": MessageLookupByLibrary.simpleMessage(
            "Belum ada kiriman tersimpan.\nMulailah menyimpan!"),
        "errorNoSearchResults": MessageLookupByLibrary.simpleMessage(
            "Tidak ada hasil.\nSilakan coba kata kunci lain!"),
        "errorNoSearchTerm": MessageLookupByLibrary.simpleMessage(
            "Masukkan kata kunci dan mulailah menjelajah!"),
        "menuAboutSubtitle": MessageLookupByLibrary.simpleMessage(
            "Informasi tentang KweeksNews"),
        "menuAboutTitle": MessageLookupByLibrary.simpleMessage("Tentang"),
        "menuContactUsSubtitle":
            MessageLookupByLibrary.simpleMessage("redaksi@kweeksnews.com"),
        "menuContactUsTitle":
            MessageLookupByLibrary.simpleMessage("Hubungi kami"),
        "menuNewStudentRegistrationSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "https://ppdb.muallimin.sch.id"),
        "menuNewStudentRegistrationTitle":
            MessageLookupByLibrary.simpleMessage("Informasi PPDB"),
        "menuSchoolWebsiteSubtitle":
            MessageLookupByLibrary.simpleMessage("https://muallimin.sch.id"),
        "menuSchoolWebsiteTitle":
            MessageLookupByLibrary.simpleMessage("Situs web sekolah"),
        "menuShareMessage": MessageLookupByLibrary.simpleMessage(
            "Unduh aplikasi KweeksNews sekarang!\nhttps://go.kweeksnews.com/app"),
        "menuShareSubtitle":
            MessageLookupByLibrary.simpleMessage("Ajak teman untuk mengunduh"),
        "menuShareTitle": MessageLookupByLibrary.simpleMessage("Bagikan"),
        "menuSubmitContentSubtitle":
            MessageLookupByLibrary.simpleMessage("Ubah dunia dengan karyamu!"),
        "menuSubmitContentTitle":
            MessageLookupByLibrary.simpleMessage("Kirim konten"),
        "menuVersionSubtitle": m13,
        "menuVersionTitle": MessageLookupByLibrary.simpleMessage("Versi"),
        "menuWebsiteSubtitle":
            MessageLookupByLibrary.simpleMessage("https://www.kweeksnews.com"),
        "menuWebsiteTitle": MessageLookupByLibrary.simpleMessage("Situs web"),
        "messageLoading": MessageLookupByLibrary.simpleMessage("Memuat..."),
        "navBarHomeLabel": MessageLookupByLibrary.simpleMessage("Beranda"),
        "navBarSavedPostsLabel":
            MessageLookupByLibrary.simpleMessage("Kiriman Tersimpan"),
        "navBarSearchLabel": MessageLookupByLibrary.simpleMessage("Cari"),
        "navBarSettingsLabel":
            MessageLookupByLibrary.simpleMessage("Pengaturan"),
        "optionContentGroupDropdownAll":
            MessageLookupByLibrary.simpleMessage("Semua"),
        "optionThemeDark": MessageLookupByLibrary.simpleMessage("Gelap"),
        "optionThemeLight": MessageLookupByLibrary.simpleMessage("Cerah"),
        "optionThemeSystem":
            MessageLookupByLibrary.simpleMessage("Sesuai sistem"),
        "pageContactTitle": MessageLookupByLibrary.simpleMessage("Kontak"),
        "pageHomeTitle": MessageLookupByLibrary.simpleMessage("Beranda"),
        "pageSavedPostsTitle":
            MessageLookupByLibrary.simpleMessage("Kiriman Tersimpan"),
        "pageSearchTitle": MessageLookupByLibrary.simpleMessage("Cari"),
        "pageSettingsTitle": MessageLookupByLibrary.simpleMessage("Pengaturan"),
        "pageSingleCategoryTitle":
            MessageLookupByLibrary.simpleMessage("Kategori"),
        "pageSingleTagTitle": MessageLookupByLibrary.simpleMessage("Tag"),
        "pageSingleUserTitle": MessageLookupByLibrary.simpleMessage("Pengguna"),
        "pageSubmitContentTitle":
            MessageLookupByLibrary.simpleMessage("Kirim Konten"),
        "searchPlaceholderText":
            MessageLookupByLibrary.simpleMessage("Masukkan kata kunci"),
        "settingLanguageSubtitle":
            MessageLookupByLibrary.simpleMessage("Bahasa tampilan aplikasi"),
        "settingLanguageTitle": MessageLookupByLibrary.simpleMessage("Bahasa"),
        "settingThemeSubtitle": MessageLookupByLibrary.simpleMessage(
            "Cerah, gelap, atau sesuai sistem"),
        "settingThemeTitle": MessageLookupByLibrary.simpleMessage("Tema"),
        "widgetRelatedPostsTitle":
            MessageLookupByLibrary.simpleMessage("Kiriman Terkait")
      };
}
