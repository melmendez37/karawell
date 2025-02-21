import 'package:supabase_flutter/supabase_flutter.dart';

class UserBadges{
  final String badgeId;
  final String userId;
  final bool isUnlocked;

  UserBadges({
    required this.badgeId,
    required this.userId,
    required this.isUnlocked,
  });

  factory UserBadges.fromMap(Map<String, dynamic> map){
    return UserBadges(
      badgeId: map['badge_id'] as String,
      userId: map['user_id'] as String,
      isUnlocked: map['is_unlocked'] ?? false,
    );
  }
}