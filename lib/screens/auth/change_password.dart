import 'package:flutter/material.dart';
import 'package:myapp/screens/profile/my_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:myapp/screens/auth/login_screen.dart';

class ChangePassword extends StatefulWidget {
  final String token;

  const ChangePassword({required this.token, Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();

}

class _ChangePasswordState extends State<ChangePassword> {
  final _passwordController = TextEditingController();

Future<void> resetPassword() async {
  try {
    final response = await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: _passwordController.text)
    );

    if(response == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password updated successfully!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update password.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${e.toString()}")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.transparent,
          title: Text(
            'Change Password',
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

        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Current password',
                  hintText: 'Enter current password',
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
                decoration: const InputDecoration(
                  labelText: 'New password',
                  hintText: 'Enter new password',
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
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  hintText: 'Confirm new password',
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
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyProfile()),
                        );
                      },
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
        )

    );
  }
}



