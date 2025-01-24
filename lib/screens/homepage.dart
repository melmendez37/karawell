import 'package:flutter/material.dart';
import 'package:myapp/screens/journaling_page.dart';
import 'package:myapp/screens/my_profile.dart';
import 'package:myapp/screens/streaks_page.dart';
import 'package:myapp/screens/chat_room.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xff027373),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Color(0xFFF2F2F2),
                  size: 40,
                ),

                SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey, User',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF2F2F2),
                      ),
                    ),

                    Text(
                      'Welcome to KaraWell',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                  ],
                ),
              ],
            ),



          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),

        iconTheme: IconThemeData(
          color: Color(0xFFF2F2F2)
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              'Progress Tracker',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'DM_Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),

            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical:20
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '---',
                          style: TextStyle(
                            fontFamily: 'DM_Sans',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.accessibility,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Daily Streaks',
                              style: TextStyle(
                                fontFamily: 'DM_Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10),


                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '---',
                          style: TextStyle(
                            fontFamily: 'DM_Sans',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bakery_dining_sharp,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Badges',
                              style: TextStyle(
                                fontFamily: 'DM_Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 50),

            Text(
              'What do you want to do today?',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'DM_Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),

            SizedBox(height: 15),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatRoom()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff027373),
                    padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      color: Color(0xFFF2F2F2),
                      size: 25,
                    ),

                    SizedBox(width: 8),

                    Text(
                      'Start new conversation',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfff2f2f2),
                      ),
                    )
                  ],
                ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StreaksPage()),
                  );
                },

                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff038C7F),
                    padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.accessibility,
                      color: Color(0xFFF2F2F2),
                      size: 25,
                    ),

                    SizedBox(width: 8),

                    Text(
                      'Check your progress',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfff2f2f2),
                      ),

                    ),
                  ],
                ),
            ),

            SizedBox(height: 50),

            Text(
              'Activity log',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'DM_Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JournalingPage()),
                );
              },

              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffd9d9d9),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Conversations of the app',
                    style: TextStyle(
                      fontFamily: 'DM_Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(width: 8),

                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 25,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JournalingPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffd9d9d9),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Sample chat',
                    style: TextStyle(
                      fontFamily: 'DM_Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(width: 8),

                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 25,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JournalingPage()),
                );
              },

              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffd9d9d9),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Progress today',
                    style: TextStyle(
                      fontFamily: 'DM_Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(width: 8),

                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      endDrawer: Drawer(
        backgroundColor: Color(0xFFF2F2F2),
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'Welcome, User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DM_Sans',
                  fontSize: 24.0
                ),
              ),

            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.black,
                size: 30.0,
              ),
              title: const Text(
                'Journaling',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM_Sans',
                    fontSize: 18.0
                ),
              ),
              onTap: (){},
            ),

            SizedBox(height: 10),

            ListTile(
              leading: Icon(
                Icons.local_fire_department,
                color: Colors.black,
                size: 30.0,
              ),
              title: const Text(
                'Daily Streaks',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM_Sans',
                    fontSize: 18.0
                ),
              ),
              onTap: (){},
            ),

            SizedBox(height: 10),

            ListTile(
              leading: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30.0,
              ),
              title: const Text(
                  'My Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM_Sans',
                    fontSize: 18.0
                  ),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              },
            ),

            SizedBox(height: 10),

            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color(0xFFFF3D00),
                size: 30.0,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF3D00),
                    fontFamily: 'DM_Sans',
                    fontSize: 18.0
                ),
              ),
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}



