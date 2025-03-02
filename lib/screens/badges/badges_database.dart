import 'package:flutter/material.dart';
import 'package:myapp/screens/badges/user_badges.dart';
import 'package:myapp/screens/notifications/notification_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/screens/badges/badges.dart';

class BadgesDatabase {
  //Database -> badges
  final database = Supabase.instance.client;

  //read badges
  final userBadgeStream = Supabase.instance.client
      .from('user_badges')
      .stream(primaryKey: ['user_id', 'badge_id'])
      .eq('user_id', Supabase.instance.client.auth.currentUser?.id as Object)
      .map((data) => data.map((badgeMap) => UserBadges.fromMap(badgeMap)).toList());

  //fetch from badges table
  Future<List<Badges>> fetchAllBadges() async {
    final userId = database.auth.currentUser?.id;
    //fetch user streaks
    final userStreak = await database
        .from('user_streaks')
        .select('counter')
        .eq('id', userId as Object)
        .maybeSingle();

    if (userStreak == null || userStreak['counter'] == null){
      return [];
    }

    final int counter = userStreak['counter'];

    final List<Map<String, dynamic>> response = await database
        .from('badges')
        .select().order('unlock_at', ascending: false);
    return response.map((badge) => Badges.fromMap(badge)).toList();



}

  Future<void> updateBadgeStatus(int counter, String userId) async {
    //fetch existing badges id
    final badgeIds = (await Supabase.instance.client
        .from('badges').select('id').eq('unlock_at', counter))
        .map((b) => b['id'])
        .toList() ?? [];

    if (badgeIds.isEmpty) return;

    //fetch user badges that match locked badge ids
    final userBadges = await database
        .from('user_badges')
        .select('badge_id')
        .eq('user_id', userId)
        .eq('is_unlocked', false)
        .inFilter('badge_id', badgeIds);

    if(userBadges.isNotEmpty){
      //fetch user badges id
      final userBadgeIds = userBadges.map((badge) => badge['badge_id']).toList();

      //update to unlock the badges
      await database.from('user_badges').update({
        'is_unlocked': true
      }).inFilter('badge_id', userBadgeIds);

      await NotificationService().showNotification(
        title: "New Badge",
        body: "You just received a new badge!"
      );
    }
  }
}