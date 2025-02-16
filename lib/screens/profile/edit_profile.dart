import 'package:flutter/material.dart';
import 'package:myapp/screens/auth/auth_service.dart';
import 'package:myapp/screens/profile/profile.dart';
import 'package:myapp/screens/profile/profile_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //work on keeping old values if some fields are not edited

  //profile db
  final profileDatabase = ProfileDatabase();
  final authService = AuthService();
  final supabase = Supabase.instance.client;

  //controllers
  final _usernameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  //user updates
  void changeProfile (Profile profile) async {
    Profile updatedProfile = Profile(
      id: profile.id,
      username: _usernameController.text,
      tagline: _taglineController.text,
      phone: _mobileNumberController.text,
    );

    try {
      //update user profile in DB
      await profileDatabase.updateProfile(profile, updatedProfile);

      // Clear the fields after update
      _usernameController.clear();
      _taglineController.clear();

      // Navigate back if needed
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $error")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getInitialProfile();
  }

  Future<void> _getInitialProfile() async {
    final id = supabase.auth.currentUser!.id;
    final data = await supabase.from('profile').select().eq('id', id).single();

    setState(() {
      _usernameController.text = data['username'];
      _taglineController.text = data['tagline'];
      _mobileNumberController.text = data['phone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentEmail = authService.getCurrentUserEmail();
    final user = supabase.auth.currentUser!;

    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
            style: TextStyle(
              fontFamily: 'DM_Sans',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
              top: Radius.circular(20),
            ),

          ),
        ),

      body: StreamBuilder(
          stream: profileDatabase.stream,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(),);
            }

            final profile = snapshot.data!.first;

            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter new username',
                      filled: true,
                      fillColor: Colors.white,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(6)
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFFCBD5E1),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(6)
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFFCBD5E1),
                            width: 1.0,
                          )
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'DM_Sans',
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF606060),
                        fontFamily: 'DM_Sans',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: _taglineController,
                    decoration: const InputDecoration(
                      labelText: 'Tagline',
                      hintText: 'What is your life motto?',
                      filled: true,
                      fillColor: Colors.white,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(6)
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFFCBD5E1),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(6)
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFFCBD5E1),
                            width: 1.0,
                          )
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'DM_Sans',
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF606060),
                        fontFamily: 'DM_Sans',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: _mobileNumberController,
                    maxLength: 13,
                    decoration: const InputDecoration(
                      labelText: 'Mobile number',
                      prefixText: '+63',
                      filled: true,
                      fillColor: Colors.white,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(6)
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFFCBD5E1),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(6)
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFFCBD5E1),
                            width: 1.0,
                          )
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'DM_Sans',
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF606060),
                        fontFamily: 'DM_Sans',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox.fromSize(),

                      ElevatedButton(
                          onPressed: () => changeProfile(profile),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff027373),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                          child: Text(
                            'Save changes',
                            style: TextStyle(
                                fontFamily: 'DM_Sans',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF2F2F2)
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            );
          }
      )

    );
  }
}



