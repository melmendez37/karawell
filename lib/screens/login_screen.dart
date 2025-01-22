import 'package:flutter/material.dart';
import 'package:myapp/screens/register_screen.dart';
import 'package:myapp/screens/homepage.dart';

class LoginScreen extends StatelessWidget {
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
          padding: EdgeInsets.all(50.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DM_Sans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),

                SizedBox(height: 40),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Username',

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        )
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        )
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height:40),

                Text(
                  'Forgot password?',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'DM_Sans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 130,
                            vertical: 10
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
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
                ),

                SizedBox(height:30),
                Text(
                  'You can also log in using:',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'DM_Sans',
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                  ),
                ),

                SizedBox(height:30),

                Text(
                  'No account yet?',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'DM_Sans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 120,
                            vertical: 10
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),

                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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



