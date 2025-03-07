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
        title: Text(
          'Journals',
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
              return Text("still no journals, how bout try and put one");
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
                        title: Text("At $date", 
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "DM_Sans",
                            fontWeight: FontWeight.bold
                        )),  // Text for the main title
                        subtitle: Text("You wrote on the journal $count times", 
                        style: const TextStyle(color: Colors.white)), // Text for the subtitle
                        leading: Icon(Icons.padding, color: Colors.white,), // Icon for the leading position
                        
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



