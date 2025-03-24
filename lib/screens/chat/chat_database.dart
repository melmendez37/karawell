import 'package:myapp/screens/Messages/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
}