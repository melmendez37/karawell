import 'package:flutter/material.dart';
import 'package:myapp/screens/Journal/journal.dart';
import 'package:myapp/screens/Journal/journal_Headers.dart';
import 'package:rxdart/rxdart.dart';
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
    List<journal_Headers> makeHeaders(List<Journal> journals){
    DateTime temp = DateTime(1999);
    List<journal_Headers> result = [];
    int count = 0;

    for(Journal journal in journals){
        if(journal.date.year == temp.year && journal.date.month == temp.month){
          if(journal.date.day == temp.day){
            count++;
          }
          else if(journal.date.day.compareTo(temp.day) > 0){
            result.add(journal_Headers(date: temp, journalCount: count));
            count = 1;
            temp = journal.date;
          }
        }
        else{
          result.add(journal_Headers(date: temp, journalCount: count));
          count = 1;
          temp = journal.date;
        }
      }
      return result;
    }
}


/*
  Stream<List<Journal>> newStream(DateTime date){

    final user = Supabase.instance.client.auth.currentUser?.id;
    final newStream = Supabase.instance.client
    .from('journal:user_id=eq.$user,date=gte.$startOfTheDay')
    .stream(primaryKey: ['id'])
    .lte('date', endOfTheDay )
    .map((data) => data.map((journalMap) => Journal.fromMap(journalMap)).toList());

    return newStream;
  }
*/
  //add to the Journal table
