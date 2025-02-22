import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  //Sign in
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up
  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );

    final userId = response.user?.id;

    //Insert blank profile
    await _supabaseClient.from('profiles').insert({
      'id': userId,
      'username': null,
      'tagline': null,
    });

    //User streak
    await _supabaseClient.from('user_streaks').insert({
      'id': userId,
      'last_opened': DateTime.now().toIso8601String(),
      'counter': 1,
    });

    //Generate user badges
    final badges = await _supabaseClient.from('badges').select('id');
    print("Fetched Badges: $badges");

    if(badges.isNotEmpty){
      final userBadges = badges.map((badge) => {
        'user_id': userId,
        'badge_id': badge['id'],
        'is_unlocked': false
      }).toList();

      //insert into user badges table
      await _supabaseClient.from('user_badges').insert(userBadges);
    }

    return response;
  }
  //Sign out
  Future<void> signOut() async {
      await _supabaseClient.auth.signOut();
  }

  //get user email
  String? getCurrentUserEmail(){
    final session = _supabaseClient.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  //reset password
  Future<void> resetPassword(String email) async{
    await _supabaseClient.auth.resetPasswordForEmail(
        email,
        redirectTo: 'http://example.com/account/update-password'
    );
  }
}