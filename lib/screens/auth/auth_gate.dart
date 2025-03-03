/*

AUTH GATE will continuously listen for auth state changes

if unauthenticated -> login page
if authenticated -> homepage


-------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:KaraWell/screens/auth/login_screen.dart';
import 'package:KaraWell/screens/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        //Listen to auth state changes
        stream: Supabase.instance.client.auth.onAuthStateChange,

        //Build appropriate page based on auth state
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          //check if there is a valid session currently
          final session = snapshot.hasData ? snapshot.data!.session : null;

          if(session != null){
            return const Homepage();
          } else{
            return const LoginScreen();
          }
        }
    );
  }
}
 