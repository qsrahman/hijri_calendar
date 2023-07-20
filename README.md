# Hijri

Hijri Date Converter
1st Muharram 1 A.H. = 16th July 622 Julian = 19th July 622 Gregorian

#### Usage

```dart
  // Suppose current gregorian data/time is: Wed Jul 12 00:27:33  2023
  var today = HijriDate.now();
  print(today.year); // 1444
  print(today.month); // 12
  print(today.day); // 23
  // Get month length in days
  print(today.daysInMonth); // 29 days
  print(today.format("MMMM dd yyyy")); //Dhu Al-Hijjah 23 1444
```

````
  ##### From Gregorian to Hijri
  ```dart
  var hdate = HijriDate.fromDate(DateTime(2018, 11, 12));
  print(hdate.toString()); //03/03/1440
  print(hdate.shortMonthName); //Rab1
  print(hdate.longMonthName); //Rabi' Al-Awwal
  print(hdate.lengthOfMonth); // 30
````

##### From Hijri to Gregorian

```dart
  //From Hijri to Gregorian
  var gdate = HijriDate(27, 7, 1415);
  print(gdate.toDateTime(1415, 7, 27)); //1994-12-30 00:00:00.000
```

##### Format

```dart
  var today = HijriDate.now();
  print(today.fullDate); //Wednesday, Dhu Al-Hijjah 23, 1444 A.H
  print(today.toFormat("mm dd yy")); //12 23 44
```

##### Month Calendar

```dart
  var today = HijriDate.now();
  today.calendar();
```

```
  Dhu Al-Hijjah 1444 A.H
Ahd Ith Zul Arb Kha Jum Sab
         01  02  03  04  06
 06  07  08  09  10  11  13
 13  14  15  16  17  18  20
 20  21  22  23  24  25  27
 27  28  29
```

## Additional information

The Julian Day Count is a uniform count of days from a remote epoch in the past (-4712 January 1, 12 hours Greenwich Mean Time (Julian proleptic Calendar) = 4713 BCE January 1, 12 hours GMT (Julian proleptic Calendar) = 4714 BCE November 24, 12 hours GMT (Gregorian proleptic Calendar)). At this instant, the Julian Day Number is 0. It is convenient for astronomers to use since it is not necessary to worry about odd numbers of days in a month, leap years, etc. Once you have the Julian Day Number of a particular date in history, it is easy to calculate time elapsed between it and any other Julian Day Number.

The Julian Day Count has nothing to do with the Julian Calendar introduced by Julius Caesar. It is named for Julius Scaliger, the father of Josephus Justus Scaliger, who invented the concept. It can also be thought of as a logical follow-on to the old Egyptian civil calendar, which also used years of constant lengths.

Scaliger chose the particular date in the remote past because it was before recorded history and because in that year, three important cycles coincided with their first year of the cycle: The 19-year Metonic Cycle, the 15-year Indiction Cycle (a Roman Taxation Cycle) and the 28-year Solar Cycle (the length of time for the old Julian Calendar to repeat exactly).
