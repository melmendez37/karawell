import 'package:supabase_flutter/supabase_flutter.dart';

class ChatSessionDatabase {
  //database -> session
  final supabase = Supabase.instance.client;
  final stopwatch = Stopwatch();

  //add chat session
  Future<void> startChatSession() async{
    final userId = supabase.auth.currentUser?.id;
    if(userId == null) return;

    final response = await supabase.from('chat_session')
        .insert({
          'user_id': userId,
          'started_at': DateTime.now().toIso8601String(),
        }).select('id').maybeSingle();

    if(response != null){
      stopwatch.reset();
      stopwatch.start();
    };
  }

  //update session when user leaves session
  Future<void> endChatSession() async {
    final userId = supabase.auth.currentUser?.id;
    if(userId == null) return;

    final now = DateTime.now();

    //fetching the latest session
    final response = await supabase
        .from('chat_session')
        .select('id, started_at, ended_at')
        .eq('user_id', userId)
        .order('started_at', ascending:false)
        .limit(1)
        .maybeSingle();

    if(response == null || response['ended_at'] != null){
      return;
    }

    final sessionId = response['id'];

    //run stopwatch if it is running
    final durationInSecs = stopwatch.elapsed.inSeconds;
    if(stopwatch.isRunning){

      stopwatch.stop();
      stopwatch.reset();
    } else {
      print("Stopwatch not running!");
    }

    await supabase.from('chat_session').update({
      'ended_at': now.toIso8601String(),
      'duration': durationInSecs,
    }).eq('id', sessionId);


  }

}