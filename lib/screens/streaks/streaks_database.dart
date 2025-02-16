import 'package:myapp/screens/streaks/streaks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StreaksDatabase {
  //Database -> profile
  final database = Supabase.instance.client.from('user_streaks');

  //Read streaks from profile
  final stream = Supabase.instance.client.from('user_streaks').stream(
      primaryKey: ['id']
  ).eq('id', Supabase.instance.client.auth.currentUser?.id as Object).map((data) => data.map((streaksMap) => Streaks.fromMap(streaksMap)).toList());
}

