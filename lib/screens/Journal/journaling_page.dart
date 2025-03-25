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
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async{
    final message = _messageController.text.trim();
    final userId = supabase.auth.currentUser?.id;

    if(userId == null) {return;}
    if(message.isNotEmpty){
      journalDatabase.addJournal(userId, message, DateTime.now());
      _messageController.clear();
    }

    setState(() {});

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    });
  }

  @override
  void initState(){
    super.initState();
  }

  void _scrollToBottom(){
    if(_scrollController.hasClients){
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
              return const Center(child: CircularProgressIndicator(
                color: Colors.white,
              ));
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
            width: double.infinity,
            height: double.infinity,
            color: Color(0xff027373),
            child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(8),
                          reverse: false,
                          itemCount: filteredMessages.length,
                          itemBuilder: (context, index) {
                            final message = filteredMessages[index];
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                color: Color(0xFF025959),
                                child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message.message,
                                          style: TextStyle(
                                            fontFamily: "DM_Sans",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            DateFormat("MMMM d,").add_jm() .format(message.date),
                                            style: const TextStyle(
                                                color: Color(0xFFD9D9D9),
                                                fontFamily: "DM_Sans",
                                                fontStyle: FontStyle.italic
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            );
                          }
                        )
                    ),

                  if(widget.date.isAfter(currentDay))
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )
                          ),
                            onPressed: (){
                              showModalBottomSheet(
                                backgroundColor: Color(0xff027373),
                                isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context){
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                        child: SizedBox(
                                            height: 300,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Add new journal',
                                                  style:TextStyle(
                                                      fontFamily: "DM_Sans",
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 22
                                                  ),
                                                ),

                                                SizedBox(height: 20,),

                                                Expanded(
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Color(0xfff2f2f2),
                                                        fontFamily: "DM_Sans"
                                                    ),
                                                    controller: _messageController,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                                      alignLabelWithHint: true,
                                                      hintText: "What's on your mind...",
                                                      hintStyle: TextStyle(
                                                        color: Color(0xFFF2F2F2),
                                                        fontFamily: "DM_Sans",
                                                        fontSize: 16,
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
                                                    minLines: 4,
                                                    maxLines: 6,
                                                  ),
                                                ),

                                                Padding(
                                                    padding: EdgeInsets.only(bottom: 40),
                                                    child:  SizedBox(
                                                      child: ElevatedButton(
                                                        onPressed: (){
                                                          sendMessage();
                                                          Navigator.pop(context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            )
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.add_box_outlined,
                                                              color: Color(0xff027373),
                                                              size: 22,
                                                            ),
                                                            SizedBox(width: 5,),
                                                            Text(
                                                              'Save journal',
                                                              style: TextStyle(
                                                                color: Color(0xff027373),
                                                                fontFamily: "DM_Sans",
                                                                fontSize:16,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                )
                                              ],
                                            ),
                                        ),
                                    );
                                  }
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xff027373),
                                  size: 22,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  'Create journal',
                                  style: TextStyle(
                                    color: Color(0xff027373),
                                    fontFamily: "DM_Sans",
                                    fontSize:16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                        ),
                      )
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



