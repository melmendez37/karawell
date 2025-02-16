import 'dart:ffi';

class Streaks{
  final String id;
  final int counter;

  Streaks({
    required this.id,
    required this.counter,
  });

  //map -> profile
  factory Streaks.fromMap(Map<String, dynamic> map){
    return Streaks(
      id: map['id'] as String,
      counter: map['counter'] as int,
    );
  }

  //profile -> map
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'counter': counter,
    };
  }
}

