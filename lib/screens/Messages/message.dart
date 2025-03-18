class Message{
  final String message;
  final bool byUser;

  const Message({
    required this.message,
    required this.byUser,
  });
  Map<String, dynamic> toMap() {
    return {
      'message' : message,
      'byUser': byUser,
    };
  }

}