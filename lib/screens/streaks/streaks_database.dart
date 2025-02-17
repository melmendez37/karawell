import 'package:myapp/screens/streaks/streaks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StreaksDatabase {
  //Database -> profile
  final database = Supabase.instance.client.from('user_streaks');

  //Read streaks from profile
  final stream = Supabase.instance.client.from('user_streaks').stream(
      primaryKey: ['id']
  ).eq('id', Supabase.instance.client.auth.currentUser?.id as Object).map((data) => data.map((streaksMap) => Streaks.fromMap(streaksMap)).toList());

  //Update streak logic
  Future<void> updateUserStreaks(String userId) async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('user_streaks')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    DateTime today = DateTime.now();
    int counter = 1;

    if(response != null) {
      DateTime lastOpened = DateTime.parse(response['last_opened']);
      int days = today.difference(lastOpened).inDays;

      if(days > 1){
        //Reset the count
        counter = 1;
      } else {
        //add one to count
        counter = response['counter'] + 1;
      }

      //Update database
      await supabase.from('user_streaks').update({
        'last_opened': today.toIso8601String(),
        'counter': counter
      }).eq('user_id', userId);
    } else {
      //Insert new record if this is not found
      await supabase.from('user_streaks').insert({
        'user_id': userId,
        'last_opened': today.toIso8601String(),
        'counter': counter,
      });
    }
  }
}

