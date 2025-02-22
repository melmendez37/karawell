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
    int counter = 0;
    int longestStreak = 0;

    if(response != null) {
      DateTime lastOpened = DateTime.parse(response['last_opened']);

      //check if day is a new day, compare based on date, not time
      DateTime lastOpenedDate = DateTime(lastOpened.year, lastOpened.month, lastOpened.day);
      DateTime todayDate = DateTime(today.year, today.month, today.day);

      //check if its a new day
      if(todayDate.isAfter(lastOpenedDate)){
        //increment the counter
        counter = response['counter'] + 1;
      } else {
        //dont add counter
        counter = response['counter'];
      }

      //update longest streak if current counter < itself
      longestStreak = response['longest_streak'];
      if(counter > longestStreak){
        longestStreak = counter;
      }

      //update db with today's date
      await supabase.from('user_streaks')
        .update({
          'last_opened': today.toIso8601String(),
          'counter': counter,
          'longest_streak': longestStreak,
        }).eq('id', userId);
    } else {
      //insert new data if not found
      await supabase.from('user_streaks').insert({
        'id': userId,
        'last_opened': today.toIso8601String(),
        'counter': counter,
        'longest_streak': counter
      });
    }

    //await updateBadgeStatus(counter, userId);
  }

  // void chatroomOpened(String userId) async {
  //   await updateUserStreaks(userId, 'opened_chatroom');
  // }
  //
  // void messageSent(String userId) async {
  //   await updateUserStreaks(userId, 'message_sent');
  // }
  //
  // void messageReacted(String userId) async {
  //   await updateUserStreaks(userId, 'message_reacted');
  // }
}

