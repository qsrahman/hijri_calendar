import 'dart:io';
import 'dart:math';

import 'package:hijri_calendar/src/constants.dart';

class HijriDate {
  late final int day;
  late final int month;
  late final int year;
  late final int weekDay;

  HijriDate(int hday, int hmonth, int hyear) {
    day = hday < 0 || hday > 30 ? 1 : hday;
    month = hmonth < 0 || hmonth > 12 ? 1 : hmonth;
    year = hyear < 0 ? 1 : hyear;

    weekDay = (toJdn() + 1.5).floor() % 7 + 1; // 1 or 1.5 ?
  }

  HijriDate.now() : this.fromDate(DateTime.now());
  HijriDate.fromDate(DateTime dt)
      : this.fromGregorian(dt.day, dt.month, dt.year);
  HijriDate.fromGregorian(int d, int m, int y)
      : this.fromJdn(HijriDate.gregorianToJdn(d, m, y));
  HijriDate.fromJdn(num jdn) {
    weekDay = (jdn + 1).floor() % 7 + 1; // 1 or 1.5 ?

    jdn = jdn.floor() + 0.5;
    year = ((30 * (jdn - hijriEpoch)) + 10646) ~/ 10631;
    month = min(12, ((jdn - (29 + HijriDate(1, 1, year).toJdn())) / 29.5) + 1)
        .ceil();
    day = (jdn - HijriDate(1, month, year).toJdn()).floor() + 1;
  }

  num toJdn() {
    num jdn = (day + // days so far this month
            (29.5 * (month - 1)).ceil() + // days so far this year...
            (year - 1) * 354 + // non-leap days in prior years
            (3 + (11 * year)) ~/ 30 + // leap days in prior years
            hijriEpoch) - // days before start of calendar
        1;

    // print('jdn from toJdn() = $jdn');
    return jdn;
  }

  DateTime toDateTime() {
    var gd = jdnToGregorian(toJdn());
    return DateTime(gd.year, gd.month, gd.day);
  }

  ({int day, int month, int year}) toGregorian() {
    return jdnToGregorian(toJdn());
  }

  bool isLeapYear() {
    // Kuwaiti algorithm
    // const List<int> leapYears = [2, 5, 7, 10, 13, 15, 18, 21, 24, 26, 29];
    // Modified Kuwaiti algorithm
    const List<int> leapYears = [2, 5, 7, 10, 13, 15, 18, 21, 23, 26, 29];
    return leapYears.contains(year % 30);

    // [1, 5, 7, 10, 13, 16, 18, 21, 24, 26, 29] in 30 years 11 leap and 19 normal
    // return (((11 * year) + 14) % 30) < 11;
  }

  static num gregorianToJdn(int d, int m, int y) {
    num jdn = (gregorianEpoch - 1) +
        (365 * (y - 1)) + // days in previous years ignoring leap days
        ((y - 1) ~/ 4) + // Julian leap days before this year...
        (-((y - 1) ~/ 100)) + // ...minus prior century years...
        ((y - 1) ~/ 400) + // ...plus prior years divisible by 400
        ((((367 * m) - 362) ~/ 12) + // days this year
            ((m <= 2) ? 0 : (isGregorianLeapYear(y) ? -1 : -2)) +
            d);

    // print('jdn from gregorianToJdn() = $jdn');
    return jdn;
  }

  static ({int day, int month, int year}) jdnToGregorian(num jdn) {
    num wjd = (jdn - 0.5).floor() + 0.5;
    num depoch = wjd - gregorianEpoch;
    int quadricent = depoch ~/ 146097;
    num dqc = depoch % 146097;
    int cent = dqc ~/ 36524;
    num dcent = dqc % 36524;
    int quad = dcent ~/ 1461;
    num dquad = dcent % 1461;
    int yindex = dquad ~/ 365;

    int y = (quadricent * 400) + (cent * 100) + (quad * 4) + yindex;
    if (!((cent == 4) || (yindex == 4))) {
      y++;
    }

    num yd = wjd - gregorianToJdn(1, 1, y);
    int leapadj = ((wjd < gregorianToJdn(1, 3, y))
        ? 0
        : (isGregorianLeapYear(y) ? 1 : 2));
    int m = ((((yd + leapadj) * 12) + 373) ~/ 367);
    int d = (wjd - gregorianToJdn(1, m, y)).floor() + 1;

    return (day: d, month: m, year: y);
  }

  static bool isGregorianLeapYear(int y) {
    // return ((y % 4) == 0) && (!(((y % 100) == 0) && ((y % 400) != 0)));
    return ((y >= 1582)
        ? ((y % 4 == 0 && y % 100 != 0) || (y % 400 == 0))
        : (y % 4 == 0));
  }

  static int daysInGregorianMonth(int m, int y) {
    switch (m) {
      case 2:
        return isGregorianLeapYear(y) ? 29 : 28;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      default:
        return 31;
    }
  }

  String format(String format) {
    String newFormat = format;

    String dayString = day.toString(); //day < 10 ? '0$day' : '$day';
    String monthString = month.toString(); //month < 10 ? '0$month' : '$month';
    String yearString = year.toString(); //year < 10 ? '0$year' : '$year';

    if (newFormat.contains("dd")) {
      newFormat = newFormat.replaceFirst("dd", dayString.padLeft(2, '0'));
    } else {
      if (newFormat.contains("d")) {
        newFormat = newFormat.replaceFirst("d", dayString);
      }
    }

    // Day Name
    if (newFormat.contains("DDDD")) {
      newFormat =
          newFormat.replaceFirst("DDDD", "${wdNames[weekDay]!['long']}");
    } else if (newFormat.contains("DD")) {
      newFormat = newFormat.replaceFirst("DD", "${wdNames[weekDay]!['short']}");
    }

    // Month
    if (newFormat.contains("mm")) {
      newFormat = newFormat.replaceFirst("mm", monthString.padLeft(2, '0'));
    } else {
      newFormat = newFormat.replaceFirst("m", monthString);
    }

    // Muharram
    if (newFormat.contains("MMMM")) {
      newFormat = newFormat.replaceFirst("MMMM", monthNames[month]!['long']!);
    } else {
      if (newFormat.contains("MM")) {
        newFormat = newFormat.replaceFirst("MM", monthNames[month]!['short']!);
      }
    }

    // Year
    if (newFormat.contains("yyyy")) {
      newFormat = newFormat.replaceFirst("yyyy", yearString);
    } else {
      if (yearString.length >= 4) {
        newFormat = newFormat.replaceFirst("yy", yearString.substring(2, 4));
      } else {
        newFormat = newFormat.replaceFirst("yy", yearString.padLeft(2, '0'));
      }
    }

    return newFormat;
  }

  void calendar() {
    List<int> cal = List.filled(42, 0); // 6x7

    int wkDay = HijriDate(1, month, year).weekDay;

    int d = 1;
    for (int c = wkDay - 1; c < 7; c++) {
      cal[c] = d++;
    }

    for (int r = 1; r < 6; r++) {
      for (int c = 0; c < 7 && d <= daysInMonth; c++) {
        cal[7 * r + c] = d++;
      }
    }

    // center header0 over header1
    String header0 = '${monthNames[month]!["long"]} $year A.H';
    String spaces = ''.padRight((header1.length - header0.length) ~/ 2, ' ');

    stdout.writeln('\n$spaces$header0');
    stdout.writeln(header1);

    for (int r = 0; r < 6; r++) {
      for (int c = 0; c < 7; c++) {
        int i = 7 * r + c;
        if (cal[i] != 0) {
          String dt = cal[i].toString().padLeft(2, '0');
          if (cal[i] == day) {
            // highlight the current date
            stdout.write(' \x1B[7m$dt\x1B[0m ');
          } else {
            stdout.write(' $dt ');
          }
        } else {
          stdout.write('    ');
        }
      }
      stdout.writeln('');
    }
  }

  int get daysInMonth =>
      (((month % 2) == 1) || ((month == 12) && isLeapYear())) ? 30 : 29;
  int get daysInYear => (toJdn() - hijriEpoch + 1).toInt();
  String get fullDate => format("DDDD, MMMM dd, yyyy A.H");
  String get longMonthName => monthNames[month]!['long']!;
  String get shortMonthName => monthNames[month]!['short']!;
  String get longDayName => wdNames[weekDay]!['long']!;
  String get shortDayName => wdNames[weekDay]!['short']!;

  List<int> toList() => [day, month, year];

  @override
  String toString() {
    return fullDate;
  }
}
