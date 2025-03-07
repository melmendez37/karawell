import 'package:flutter/material.dart';
import 'package:myapp/screens/auth/register_screen.dart';
import 'package:myapp/screens/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //get auth service
    final authService  = AuthService();

    //text controllers
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    //when login button is pressed
    void login() async {
      //prepare data
      final email = _emailController.text;
      final password = _passwordController.text;

      //attempt logging in,
      try{
        await authService.signInWithEmailPassword(email, password);

      }

      //catch errors
      catch (e) {
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: $e"))
          );
        }
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff027373),
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
                  controller: _emailController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textCapitalization: TextCapitalization.none,
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

                SizedBox(height:20),

                ElevatedButton(
                    onPressed: login,
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

                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
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
                      'No account yet? Sign Up',
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



