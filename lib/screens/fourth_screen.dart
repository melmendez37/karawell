import 'package:flutter/material.dart';
import 'package:myapp/screens/fifth_screen.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xffffffff),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.black,
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
                      ),
                    ),

                    Text(
                      'Welcome to KaraWell',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Icon(
              Icons.menu,
              color: Colors.black,
            )

          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
            top: Radius.circular(20),
          ),

        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(height: 10),
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
                        vertical:40
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical:40
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 35),

            ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff027373),
                    padding: EdgeInsets.symmetric(
                        horizontal: 70,
                        vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),

                child: Text(
                  'Start new conversation',
                  style: TextStyle(
                    fontFamily: 'DM_Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff2f2f2),
                  ),
                )
            ),

            SizedBox(height: 20),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FifthScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff038C7F),
                    padding: EdgeInsets.symmetric(
                        horizontal: 116,
                        vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),

                child: Text(
                  'Your daily progress',
                  style: TextStyle(
                    fontFamily: 'DM_Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff2f2f2),
                  ),

                )
            ),

            SizedBox(height: 35),

            Text(
              'Gamification features',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'DM_Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}



