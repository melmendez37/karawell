import 'package:myapp/screens/Journal/journal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JournalDatabase {

  //getting the journal table from DB
  final database = Supabase.instance.client.from('journal');

  //getting the user's journals 
  final stream = Supabase.instance.client
  .from('journal')
  .stream(primaryKey: ['id'])
  .eq('user_id', Supabase.instance.client.auth.currentUser?.id as Object)
  .map((data) => data.map((journalMap) => Journal.fromMap(journalMap)).toList());
  
  Future<void> addJournal(String uuid, String message, DateTime date) async {

        if(uuid.isNotEmpty && message.isNotEmpty){
         await database.insert({
        'user_id': uuid,
        'message': message,
        'date': date.toIso8601String(),
      });
        }
  } 

}

  //add to the Journal table
