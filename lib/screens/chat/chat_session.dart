class ChatSession {
  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int? duration;

  ChatSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    this.duration,
  });

  //map -> session
  factory ChatSession.fromMap(Map<String, dynamic> map){
    return ChatSession(
        id: map['id'] as String,
        startedAt: map['started_at'] != null
            ? DateTime.parse(map['started_at'] as String)
            : DateTime.now(),
        endedAt: map['ended_at'] != null
            ? DateTime.parse(map['ended_at'] as String)
            : DateTime.now(),
        duration: map['duration'] != null ? map['duration'] as int : 0,
    );
  }

  //session -> map
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'started_at': startedAt,
      'ended_at': endedAt,
      'duration': duration
    };
  }
}