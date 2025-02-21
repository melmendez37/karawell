import 'package:flutter/material.dart';
import 'package:myapp/screens/streaks/streaks_database.dart';
import 'package:table_calendar/table_calendar.dart';

class StreaksPage extends StatefulWidget {
  const StreaksPage({super.key});

  @override
  State<StreaksPage> createState() => _StreaksPageState();
}

class _StreaksPageState extends State<StreaksPage> {
  final streaksDatabase = StreaksDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xffffffff),
        title: StreamBuilder(
            stream: streaksDatabase.stream,
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final streaks = snapshot.data!.first;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Streaks',
                    style: TextStyle(
                      fontFamily: 'DM_Sans',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${streaks.counter}',
                                  style: TextStyle(
                                    fontFamily: 'DM_Sans',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  ' ${streaks.longestStreak}',
                                  style: TextStyle(
                                    fontFamily: 'DM_Sans',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
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
          stream: streaksDatabase.stream,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final streaks = snapshot.data!.first;

            return Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                        child: GridView.count(
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 25,
                          crossAxisCount: 3,
                          children: List.generate(21, (index) {
                            bool isActive = index < streaks.counter;
                            bool isMedal = index == 0 || index == 2 || index == 6 || index == 13 || index == 20;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 25
                                  ),
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.green : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                          isMedal ? Icons.emoji_flags : Icons.sunny,
                                          size: 35,
                                          color: isActive ? Colors.white : Colors.grey,
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Day ${index + 1}',
                                            style: TextStyle(
                                              fontFamily: 'DM_Sans',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: isActive ? Colors.white : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                    )

                  ],
                ),
            );
          }
      )


    );
  }
}



