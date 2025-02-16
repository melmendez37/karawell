import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class StreaksPage extends StatelessWidget {
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
        padding: EdgeInsets.all(20.0),
         child: Column(
           children: [
             TableCalendar(
                  locale: 'en_US',
                 focusedDay: DateTime.now(),
                 headerStyle: HeaderStyle(
                     formatButtonVisible: false,
                     titleCentered: true,
                     titleTextStyle: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                       fontFamily: 'DM_Sans'
                    )
                 ),
                 firstDay: DateTime.utc(2025, 2, 1),
                 lastDay: DateTime(2030, 2, 1),
                rowHeight: 70,
               calendarBuilders: CalendarBuilders(
                 defaultBuilder: (context, date, focusedDay){
                   bool isCurrentMonth = date.month == focusedDay.month;

                   return Container(
                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                     decoration: BoxDecoration(
                       color: isCurrentMonth ? Colors.white : Colors.grey[200],
                     ),
                     alignment: Alignment.center,
                     child: Text(
                       date.day.toString(),
                       style: TextStyle(
                       fontSize: 18,
                       fontFamily: "DM_Sans",
                       color: Colors.black, // Black font color
                       ),
                     ),
                   );
                 },
                 todayBuilder: (context, date, focusedDay){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFF038C7F),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                        color: Colors.white, // White text for contrast
                      ),
                    ),
                  );
                 }
               ),
             ),

           ],
         )
      ),
    );
  }
}



