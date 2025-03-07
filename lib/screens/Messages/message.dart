class Message{
  final String message;
  final bool byUser;
  final DateTime currentTime;

  const Message({
    required this.message,
    required this.byUser,
    required this.currentTime,
  });
  Map<String, dynamic> toMap() {
    return {
      'message' : message,
      'byUser': byUser,
      'currentTime': currentTime.toIso8601String(),
    };
  }

}