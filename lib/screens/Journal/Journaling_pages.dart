import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/Journal/journal.dart';
import 'package:myapp/screens/Journal/journaling_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/screens/Journal/journal_database.dart';
import 'package:myapp/screens/Journal/journal.dart';

class JournalingPages extends StatefulWidget {
  const JournalingPages({super.key});

  @override
  State<JournalingPages> createState() => _JournalingPagesState();
}

class _JournalingPagesState extends State<JournalingPages> {
  final supabase = Supabase.instance.client.auth.currentUser?.id;

  final journalDatabase = JournalDatabase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xffffffff),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Journals',
              style: TextStyle(
                fontFamily: 'DM_Sans',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JournalingPage(date: DateTime.now(),)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff057569),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'Add',
                      style: TextStyle(
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white
                      ),
                    )
                  ],
                )
            )
          ],
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

      body: StreamBuilder<List<Journal>>(
          stream: journalDatabase.stream,
          builder: (context, snapShot){
            if(!snapShot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final journals = snapShot.data!;
            if(journals.isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_outlined,
                          size: 40,
                        ),
                        SizedBox(width:10),
                        Text(
                          "No journals?",
                          style: TextStyle(
                              fontFamily: "DM_Sans",
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Text(
                      "Tap the Add button to begin!",
                      style: TextStyle(
                          fontFamily: "DM_Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              );
            }
            final headers = journalDatabase.makeHeaders(journals);

            return ListView.builder(
                itemCount: headers.length,
                itemBuilder: (context, index){
                  final header = headers[index];
                  final date = DateFormat.yMMMMd('en_US').format(header.date);
                  final count = header.journalCount;

                  return Center(
                  child: ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(25),
                        color: Color(0xff057569),

                      ),
                      child: ListTile(
                        title: Text("$date",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "DM_Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        )),  // Text for the main title
                        subtitle: Text("Wrote $count ${count == 1 ? "journal" : "journals"}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "DM_Sans",
                            fontSize: 14,
                        )), // Text for the subtitle
                        leading: Icon(Icons.notes_outlined, color: Colors.white,), // Icon for the leading position
                        
                        onTap: () => {
                          Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => JournalingPage(date: header.date,)))
                        },
                      ),
                    ),
                  ),
                );
              
           });
          }
      )
    );
  }
}



