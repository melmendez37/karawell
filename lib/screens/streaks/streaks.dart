import 'dart:ffi';

class Streaks{
  final String id;
  final int counter;
  final int longestStreak;
  final DateTime lastActiveDate;

  Streaks({
    required this.id,
    required this.counter,
    required this.longestStreak,
    required this.lastActiveDate,
  });

  //map -> profile
  factory Streaks.fromMap(Map<String, dynamic> map){
    return Streaks(
      id: map['id'] as String,
      counter: map['counter'] as int,
      longestStreak: map['longest_streak'] as int,
      lastActiveDate: DateTime.parse(map['last_active_date']),
    );
  }

  //profile -> map
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'counter': counter,
      'longest_streak': longestStreak,
      'last_active_date': lastActiveDate.toIso8601String(),
    };
  }
}

