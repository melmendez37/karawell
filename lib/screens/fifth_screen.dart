import 'package:flutter/material.dart';

class FifthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xffffffff),
        title: Text(
          'Daily Streaks',
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
        padding: EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              padding: EdgeInsets.all(100.0),
              decoration: BoxDecoration(
                color: Color(0xFF038C7F),
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              Icons.money,
                              color: Color(0xFFE8AE00),
                              size:24
                          ),
                          Text(
                            '20K',
                            style: TextStyle(
                              fontFamily: 'DM_Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Day 1',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10.0),

                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              Icons.money,
                              color: Color(0xFFE8AE00),
                              size:24
                          ),
                          Text(
                            '20K',
                            style: TextStyle(
                              fontFamily: 'DM_Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Day 2',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10.0),

                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 25.0
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              Icons.bakery_dining_sharp,
                              color: Color(0xFFFF3D00),
                              size:24
                          ),
                          Text(
                            'Badge',
                            style: TextStyle(
                              fontFamily: 'DM_Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Day 3',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.money,
                            color: Color(0xFFE8AE00),
                            size:24
                          ),
                          Text(
                            '20K',
                            style: TextStyle(
                              fontFamily: 'DM_Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                        'Day 4',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10.0),

                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              Icons.money,
                              color: Color(0xFFE8AE00),
                              size:24
                          ),
                          Text(
                            '20K',
                            style: TextStyle(
                              fontFamily: 'DM_Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Day 5',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10.0),

                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              Icons.money,
                              color: Color(0xFFE8AE00),
                              size:24
                          ),
                          Text(
                            '20K',
                            style: TextStyle(
                              fontFamily: 'DM_Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Day 6',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}



