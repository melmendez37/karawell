import 'package:flutter/material.dart';
import 'package:KaraWell/screens/auth/auth_service.dart';
import 'package:KaraWell/screens/profile/edit_profile.dart';
import 'package:KaraWell/screens/profile/profile_database.dart';
import 'package:KaraWell/screens/profile/profile_picture.dart';

class MyProfile extends StatefulWidget{
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  //get auth service
  final authService = AuthService();
  final profileDatabase = ProfileDatabase();

  @override
  Widget build(BuildContext context) {

    final currentEmail = authService.getCurrentUserEmail();


    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        title: Text(
          'My Profile',
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
        //
        stream: profileDatabase.stream,
        builder: (context, snapshot){

          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final profile = snapshot.data!.first;

          return Column(
            children: [
              Container(
                height: 350,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: profile.imageUrl != null
                      ? NetworkImage(profile.imageUrl!)
                      : AssetImage('assets/img-1.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            image: AssetImage('assets/karawell-name-light.png'),
                          ),
                          IconButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditProfile()),
                                );
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 100),

                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.username ?? 'No username yet...',
                                  style: TextStyle(
                                      fontFamily: 'DM_Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Color(0xFFF2F2F2)
                                  ),
                                ),
                                Text(
                                  profile.tagline ?? 'This is where your tagline will be.',
                                  style: TextStyle(
                                      fontFamily: 'DM_Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFFD9D9D9)
                                  ),
                                ),
                              ],
                            ),
                            SizedBox.fromSize(),
                          ],
                        )
                    )
                  ],
                ),
              ),

              //another container
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Mobile Number:',
                                  style: TextStyle(
                                      fontFamily: 'DM_Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),

                                //where the phone number should be
                                Text(
                                  profile.phone != null ? "+639${profile.phone}" : 'Not added',
                                  style: TextStyle(
                                      fontFamily: 'DM_Sans',
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email address:',
                                  style: TextStyle(
                                      fontFamily: 'DM_Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),

                                //where the user's email should be
                                Text(
                                  currentEmail.toString(),
                                  style: TextStyle(
                                      fontFamily: 'DM_Sans',
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EditProfile()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff027373),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                    child: Text(
                                      'Edit profile',
                                      style: TextStyle(
                                          fontFamily: 'DM_Sans',
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFF2F2F2)
                                      ),
                                    )
                                ),

                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProfilePicture()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff3d3d3d),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                    child: Text(
                                      'Upload photo',
                                      style: TextStyle(
                                          fontFamily: 'DM_Sans',
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFF2F2F2)
                                      ),
                                    )
                                ),
                              ],
                            )

                          ],
                        )
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      )
    );
  }
}



