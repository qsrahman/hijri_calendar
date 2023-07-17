import 'package:hijri_calendar/hijri_calendar.dart';

void main() {
  HijriDate today = HijriDate.now();

  today.printCalendar();

  // print('Today hijri date: $today');
  print('Today hijri date: ${today.fullDate}');

  // num jdn0 = HijriDate.gregornToJdn(19, 7, 622);
  // num jdn1 = HijriDate(1, 1, 1).toJdn();

  // print('(19, 7, 622) = $jdn0');
  // print('(1, 1, 1) = $jdn1');

  // var gd = HijriDate.jdnToGregorian(jdn0);
  // var hd = HijriDate.fromJdn(jdn0);
  // print('$gd = $hd');

  // var hDate = HijriDate.fromDate(DateTime(2018, 11, 12));
  // print(hDate.toString()); //03/03/1440H
  // print(hDate.shortMonthName); //Rab1
  // print(hDate.longMonthName); //Rabi' Al-Awwal
  // print(hDate.lengthOfMonth()); // 30

  // var gDate = HijriDate(27, 7, 1415);
  // print(gDate.toDateTime()); //1994-12-30 00:00:00.000

  // print(today.fullDate); //Wednesday, Dhu Al-Hijjah 23, 1444 A.H
  // print(today.format("mm dd yy")); //12 23 44
}
