import 'package:flutter/material.dart';

class SixthScreen extends StatelessWidget {
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
          padding: EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image(
                    image: AssetImage('assets/reward-logo.png'),
                ),

                SizedBox(height: 30),

                Text(''
                    'Congratulations! You have received a badge!',
                  style: TextStyle(
                    fontFamily: 'DM_Sans',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                    'We are extremely happy for you and the progress you made. Keep it up!',
                  style: TextStyle(
                    fontFamily: 'DM_Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 30),

                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF2F2F2),
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),

                    ),
                    child: Text(
                        'Back',
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontWeight: FontWeight.bold,
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



