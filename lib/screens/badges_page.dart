import 'package:flutter/material.dart';


class BadgesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xffffffff),
        title: Text(
          'Badges',
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

      body: ListView(
          children: [
            SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),

                )
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),                )
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),                )
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),              ),
            ),
          ],

      ),
    );
  }
}



