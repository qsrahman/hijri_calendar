import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:test/test.dart';

void main() {
  HijriDate hijriDate = HijriDate(30, 10, 1439);

  group('Hijri', () {
    test('produces the correct date', () {
      expect(HijriDate.fromDate(DateTime(2020, 5, 20)).toList(),
          equals([27, 9, 1441]));
    });
    test('format date', () {
      expect(HijriDate.fromDate(DateTime(2018, 5, 27)).format("dd mm yy"),
          equals("12 09 39"));
    });
    test('days in month', () {
      expect(hijriDate.daysInMonth, equals(29));
    });
    test('format', () {
      expect(
          hijriDate.format("DDDD MM yyyy dd"), equals("Sunday Shaw 1439 30"));
      expect(hijriDate.format("DD MMMM yy d"), equals("Sun Shawwal 39 30"));
      expect(hijriDate.format("MMMM"), equals("Shawwal"));
      expect(hijriDate.format("MM"), equals("Shaw"));
      expect(hijriDate.format("dd"), equals("30"));
      expect(hijriDate.format("d"), equals("30"));
      expect(hijriDate.format("yyyy"), equals("1439"));
      expect(hijriDate.format("yy"), equals("39"));
    });
    group('Gregorian', () {
      test('convert Hijri to Gregorian', () {
        expect(HijriDate(12, 10, 1439).toDateTime(),
            equals(DateTime(2018, 06, 26, 00, 00, 00, 000)));
      });
    });
  });
}
