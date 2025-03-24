import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/Messages/message.dart';
import 'package:myapp/screens/Messages/messagingHeaders.dart';
import 'package:myapp/screens/chat/chat_room.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/screens/chat/chat_database.dart';

class ChatLogs extends StatefulWidget {
  const ChatLogs({super.key});

  @override
  State<ChatLogs> createState() => _ChatLogsState();
}

class _ChatLogsState extends State<ChatLogs> {
  final supabase = Supabase.instance.client.auth.currentUser?.id;
  List<MessagingHeaders> headers = [];
  final chatDatabase = MessageDatabase();

  @override
  void initState() {
    super.initState();
    getHeaders();
  }

  Future<void> getHeaders() async {
    final output = await chatDatabase.makeHeaders();
    if(output.isNotEmpty){
      setState(() {
        headers += output;
      });
    }

  }


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
              'Chats',
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
                    MaterialPageRoute(builder: (context) => ChatRoom(chatId: "",)),
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

      body: StreamBuilder<List<Message>>(
          stream: chatDatabase.stream,
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
                          "No Conversations?",
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
            return GroupedListView<MessagingHeaders, DateTime>(
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                padding: const EdgeInsets.all(8),
                floatingHeader: true,
                elements: headers,
                groupBy: (header) => DateTime(
                header.date.day,
              ),
              groupHeaderBuilder: (MessagingHeaders header) => SizedBox(
                height: 45,
                  child: Center(
                    child: Card(
                      color: Color(0xff057569),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          DateFormat("MMMM d").format(header.date),
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "DM_Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        )),  
                        ),
                      ),
                    ),
                  ),
                itemBuilder: (context, MessagingHeaders header) => Center(
                  child: ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(25),
                        color: Color(0xff057569),

                      ),
                      child: ListTile(
                        title: Text(DateFormat.jms('en_US').format(header.date),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "DM_Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        )),  // Text for the main title
                        subtitle: Text("The conversation had ${header.count} ${header.count == 1 ? "chat" : "chats"}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "DM_Sans",
                            fontSize: 14,
                        )), // Text for the subtitle
                        leading: Icon(Icons.notes_outlined, color: Colors.white,), // Icon for the leading position
                        
                        onTap: () => {
                          Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => ChatRoom(chatId: header.id!,)))
                        },
                      ),
                    ),
                  ),
                )
              
           );
          }
      )
    );
  }
}



