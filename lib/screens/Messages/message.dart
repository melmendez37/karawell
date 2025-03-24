class Message{
  final int id;
  final String uuid;
  final String chat_id;
  final String message;
  final bool byUser;

  const Message({
    required this.id,
    required this.uuid,
    required this.chat_id,
    required this.message,
    required this.byUser
  });
    //map -> Message
    factory Message.fromMap(Map<String, dynamic> map){
    return Message(
        id: map['id'],
        uuid: map['user_id'] as String,
        chat_id: map['chat_id'] as String,
        message: map['message'] as String,
        byUser:  map['by_user'] as bool
    );
  }


  //Message -> map
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'user_id': uuid,
      'chat_id': chat_id,
      'message': message,
      'by_user': byUser,
    };
  }
}