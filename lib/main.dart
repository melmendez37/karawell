import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/screens/auth/auth_gate.dart';
import 'package:myapp/screens/auth/change_password.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //load .env
  await dotenv.load();

  //Supabase Setup
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: AuthGate(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xff00737C),
                  Color(0xff057569),
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
                tileMode: TileMode.mirror,
              ),
            ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image(
                  image: AssetImage('assets/karawell-intro-logo.png'),
                ),
                Text(
                  'Calm and Clarity.',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DM_Sans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'That is what KaraWell is all about. Begin your journey towards peace of mind now.',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'DM_Sans',
                      color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                    ),

                    child: Text(
                        'Log In',
                        style: TextStyle(
                          fontFamily: 'DM_Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                    )


                )

              ]
            ),
          ),
        ),
    );
  }
}



