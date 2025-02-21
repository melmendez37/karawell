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

  Future<Badges?> fetchBadge(String badgeId) async {
    final response = await database.from('badges').select('*').eq('badge_id', badgeId).single();

    return Badges.fromMap(response);
  }
}