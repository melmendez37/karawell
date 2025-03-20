import 'package:myapp/screens/notifications/notification_service.dart';
import 'package:myapp/screens/streaks/streaks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StreaksDatabase {
  //Database -> streaks
  final database = Supabase.instance.client.from('user_streaks');

  //Read streaks from profile
  final stream = Supabase.instance.client
      .from('user_streaks')
      .stream(primaryKey: ['id'])
      .eq('id', Supabase.instance.client.auth.currentUser?.id as Object)
      .map((data) => data.map((streaksMap) => Streaks.fromMap(streaksMap)).toList());

  //Update streak logic
  Future<void> updateUserStreaks(String userId) async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('user_streaks')
        .select()
        .eq('id', userId)
        .maybeSingle();

    DateTime today = DateTime.now();
    int counter = response?['counter'] ?? 0;
    int longestStreak = response?['longest_streak'] ?? 0;


    if(response != null) {
      DateTime? lastMessageDate = response['last_message_date'] != null
          ? DateTime.parse(response['last_message_date'])
          : null;

      if(lastMessageDate == null){
        counter = 1;
        longestStreak = 1;
      } else {
        //check if day is a new day, compare based on date, not time
        DateTime lastDate = DateTime(lastMessageDate.year, lastMessageDate.month, lastMessageDate.day);
        DateTime todayDate = DateTime(today.year, today.month, today.day);

        //check if its a new day
        if(todayDate.isAfter(lastDate)){
          int daysDiff = todayDate.difference(lastDate).inDays;
          if(daysDiff == 1){
            //increment the counter if within one day has passed
            counter = response['counter'] + 1;
          } else if (daysDiff > 1) {
            //dont add counter if more than one day has passed
            counter = 1;
          }
        }
        //update longest streak if current counter < itself
        //longestStreak = response['longest_streak'];
        if(counter > longestStreak){
          longestStreak = counter;
        }
      }

      //update db with today's date
      await supabase.from('user_streaks')
        .update({
          'last_message_date': today.toIso8601String(),
          'counter': counter,
          'longest_streak': longestStreak,
        }).eq('id', userId);

    } else {
      //insert new data if not found
      await supabase.from('user_streaks').insert({
        'id': userId,
        'last_message_date': today.toIso8601String(),
        'counter': 1,
        'longest_streak': 1
      });
    }


  }

}

