import 'package:flutter/material.dart';
import 'package:myapp/screens/badges/user_badges.dart';
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
  Future<Badges?> fetchBadge(String badgeId) async {
    final response = await database.from('badges').select('*').eq('id', badgeId).single();

    return Badges.fromMap(response);
  }

  Future<void> updateBadgeStatus(int counter, String userId) async {
    //fetch user badges
    final badges = await Supabase.instance.client.from('user_badges').select().eq('user_id', userId);

    for (var badge in badges){
      //if badge unlocks at 1,3,5,7,14,21 then update its status
      if([1,3,5,7,14,21].contains(counter) && !badge['is_unlocked']){
        await database.from('user_badges').update({
          'is_unlocked': true
        }).eq('id', badge['id']);
      }
    }
  }
}