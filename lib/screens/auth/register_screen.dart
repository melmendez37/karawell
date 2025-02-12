import 'package:flutter/material.dart';

import 'auth_service.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    //get auth service
    final authService  = AuthService();

    //text controllers
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPassController = TextEditingController();

    //when sign up button is pressed
    void signUp() async {
      //prepare data
      final email = _emailController.text;
      final password = _passwordController.text;
      final confirmPass = _confirmPassController.text;

      //check if passwords match
      if(password != confirmPass){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Passwords don't match")
            )
        );
        return;
      }

      //try signing up
      try{
        await authService.signUpWithEmailPassword(email, password);

        //remove register page
        Navigator.pop(context);
      }

      //catch any error
      catch (e) {
        if (mounted){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error: $e')
              )
          );
        }
      }
    }

    return Scaffold(
      body: Container(
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
                  'Register account',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DM_Sans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),

                SizedBox(height: 40),

                TextFormField(
                  controller: _emailController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    hintText: 'Enter email address',

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
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
                  controller: _passwordController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  obscureText: true,
                ),

                SizedBox(height: 30),

                TextFormField(
                  controller: _confirmPassController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
                    hintText: 'Confirm password',

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  obscureText: true,
                ),

                SizedBox(height:40),

                ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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
                        color: Colors.teal,
                      ),
                    )
                ),

                SizedBox(height:30),

                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    child: Text(
                      'Already have an account? Log In',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 16,
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



