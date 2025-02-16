import 'package:myapp/screens/profile/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDatabase{
  //Database -> profile
  final database = Supabase.instance.client.from('profiles');

  //Create
  Future createProfile(Profile newProfile) async{
    await database.insert(newProfile.toMap());
  }

  //Read
  final stream = Supabase.instance.client.from('profiles').stream(
      primaryKey: ['id']
  ).eq('id', Supabase.instance.client.auth.currentUser?.id as Object).map((data) => data.map((profileMap) => Profile.fromMap(profileMap)).toList());

  //Update
  Future updateProfile (Profile profile, Profile newProfile) async {
    await database.update({
      'id' : profile.id,
      'username' : newProfile.username ?? '',
      'tagline' : newProfile.tagline ?? '',
      'phone' : newProfile.phone ?? ''
    }).eq('id', profile.id).select();
  }
}