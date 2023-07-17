const Map<int, Map<String, String>> monthNames = {
  1: {'short': 'Muh', 'long': 'Muharram'},
  2: {'short': 'Saf', 'long': 'Safar'},
  3: {'short': 'Rab1', 'long': 'Rabi\' Al-Awwal'},
  4: {'short': 'Rab2', 'long': 'Rabi\' Al-Thani'},
  5: {'short': 'Jum1', 'long': 'Jumada Al-Awwal'},
  6: {'short': 'Jum2', 'long': 'Jumada Al-Thani'},
  7: {'short': 'Raj', 'long': 'Rajab'},
  8: {'short': 'Sha\'', 'long': 'Sha\'aban'},
  9: {'short': 'Ram', 'long': 'Ramadan'},
  10: {'short': 'Shaw', 'long': 'Shawwal'},
  11: {'short': 'DhuQ', 'long': 'Dhu Al-Qi\'dah'},
  12: {'short': 'DhuH', 'long': 'Dhu Al-Hijjah'},
};

// const String header1 = 'Sun Mon Tue Wed Thu Fri Sat';
// const Map<int, Map<String, String>> wdNames = {
//   7: {'short': 'Sun', 'long': 'Sunday'},
//   1: {'short': 'Mon', 'long': 'Monday'},
//   2: {'short': 'Tue', 'long': 'Tuesday'},
//   3: {'short': 'Wed', 'long': 'Wednesday'},
//   4: {'short': 'Thu', 'long': 'Thursday'},
//   5: {'short': 'Fri', 'long': 'Friday'},
//   6: {'short': 'Sat', 'long': 'Saturday'},
// };

const String header1 = 'Ahd Ith Zul Arb Kha Jum Sab';
const Map<int, Map<String, String>> wdNames = {
  7: {'short': 'Ahd', 'long': 'Al-Aḥad'},
  1: {'short': 'Ith', 'long': 'Al-Ithnayn'},
  2: {'short': 'Zul', 'long': 'Ath-Thulāthā'},
  3: {'short': 'Arb', 'long': 'Al-Arbiā'},
  4: {'short': 'Kha', 'long': 'Al-Khamīs'},
  5: {'short': 'Jum', 'long': 'Al-Jumah'},
  6: {'short': 'Sab', 'long': 'As-Sabt'},
};


const num hijriEpoch = 1948439.5;
const num gregornEpoch = 1721425.5;
