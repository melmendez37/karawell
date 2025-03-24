import 'package:myapp/screens/Messages/message.dart';
import 'package:myapp/screens/chat/chat_session.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/screens/Messages/messagingHeaders.dart';
class MessageDatabase {

  //getting the Message table from DB
  final database = Supabase.instance.client.from('user_chat');

  //getting the user's Messages
  final stream = Supabase.instance.client
  .from('user_chat')
  .stream(primaryKey: ['id', 'user_id'])
  .eq('user_id', Supabase.instance.client.auth.currentUser?.id as Object)
  .map((data) => data.map((messageMap) => Message.fromMap(messageMap)).toList());
  
  Future<void> addMessage(String uuid, String chat_id, String message, bool byUser) async {

        if(uuid.isNotEmpty && message.isNotEmpty){
         await database.insert({
          'user_id': uuid,
          'chat_id': chat_id,
          'message': message,
          'by_user': byUser,
      });
        }
  } 

  Future<List<MessagingHeaders>> makeHeaders() async{
    final userId = Supabase.instance.client.auth.currentUser?.id as Object;
    final  response = await database
        .select()
        .eq('user_id', userId)
        .order('chat_id');

    if(response.isEmpty){return [];}
    List<Message> messages = response.map((message) => Message.fromMap(message)).toList();
    List<MessagingHeaders> result = [];

      var map = {};

      for (var x in messages) {
        map[x.chat_id] = !map.containsKey(x.chat_id) ? (1) : (map[x.chat_id] + 1);
      }


    final List<Map<String, dynamic>> response2 = await Supabase.instance.client
        .from('chat_session')
        .select('id, started_at')
        .inFilter('id', map.keys.toList())
        .order('started_at', ascending:false);
    if(response2.isEmpty){return [];}
    
    List<ChatSession> sessions = response2.map((session) => ChatSession.fromMap(session)).toList();

    for(ChatSession session in sessions){
      int temp = map[session.id];
        result.add(MessagingHeaders(date: session.startedAt, count: temp, kind: "message", id: session.id));
      }
      return result;
    }
}