import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/screens/Journal/journal.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:myapp/screens/Journal/journal_database.dart';

class JournalingPage extends StatefulWidget{
  final DateTime date ;
  const JournalingPage(
      { 
        required this.date, 
        super.key
      }
    );

  @override
  State<JournalingPage> createState() => _JournalingPageState(); 
}

class _JournalingPageState extends State<JournalingPage> {
  
  final supabase = Supabase.instance.client;
  final journalDatabase = JournalDatabase();
  final _messageController = TextEditingController();

  void sendMessage() async{
    final message = _messageController.text.trim();
    final userId = supabase.auth.currentUser?.id;

    if(userId == null) {return;}
    if(message.isNotEmpty){
      journalDatabase.addJournal(userId, message, DateTime.now());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        title: Text(
          'My Journal',
          style: TextStyle(
            fontFamily: 'DM_Sans',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF2F2F2)
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () async {
            if(context.mounted){
              Navigator.pop(context);
            }
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
            top: Radius.circular(20),
          ),

        ),
      ),


        body: StreamBuilder(
          
          //listens to this stream
          stream: journalDatabase.stream,
          //UI builder
           builder:  (context, snapshot) {

            //loading
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            // loaded!
            final messages = snapshot.data!;

                // this gives you the first millisecond of the day    
                var startOfTheDay = DateTime.utc(widget.date.year, widget.date.month, widget.date.day);
                //and this gives you the first millisecond of the next day   
                var endOfTheDay = startOfTheDay.add(Duration(days: 1));
                var currentDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
            final filteredMessages = messages.where((journal) => journal.date.isAfter(startOfTheDay) && journal.date.isBefore(endOfTheDay)).toList();

          return Container(
            decoration: BoxDecoration(
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
            child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: GroupedListView<Journal, DateTime>(
                          padding: const EdgeInsets.all(8),
                          reverse: true,
                          order: GroupedListOrder.DESC,
                          useStickyGroupSeparators: true,
                          floatingHeader: true,
                          elements: filteredMessages,
                          groupBy: (message) => DateTime(
                            message.date.day,
                            message.date.hour,
                            message.date.minute,
                          ),
                          groupHeaderBuilder: (Journal message) => SizedBox(
                            height: 40,
                            child: Center(
                              child: Card(
                                color: Theme.of(context).highlightColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    DateFormat("MMMM d,").add_jm() .format(message.date),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemBuilder: (context, Journal message) => Align(
                            alignment: Alignment.centerLeft,
                            child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(message.message),
                              ),
                          ),
                          ),
                        )
                    ),

                  if(widget.date.isAfter(currentDay))
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                              color: Colors.white,
                              ),
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: TextStyle(
                                  color: Color(0xFFF2F2F2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF2F2F2),
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF2F2F2),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF2F2F2),
                                    width: 2,
                                  ),
                                ),

                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: sendMessage,
                            icon: Icon(
                                Icons.send,
                                color: Color(0xFFF2F2F2)
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),
        );
           }
           
           ) 
        

    );
  }
}



