import 'package:flutter/material.dart';
import 'package:myapp/screens/profile/my_profile.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

      body: Padding(
          padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Last name',
                hintText: 'Enter last name',
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
                labelText: 'First name',
                hintText: 'Enter first name',
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
                labelText: 'Middle name',
                hintText: 'Enter middle name',
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
              decoration: const InputDecoration(
                labelText: 'Mobile number',
                hintText: 'Enter mobile number',
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
                labelText: 'Email address',
                hintText: 'Enter email address',
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



