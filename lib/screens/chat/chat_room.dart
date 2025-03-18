import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/screens/badges/badges_database.dart';
import 'package:myapp/screens/chat/chat_api.dart';
import 'package:myapp/screens/chat/chat_session_database.dart';
import 'package:myapp/screens/streaks/streaks_database.dart';
import 'package:myapp/screens/notifications/notification_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/screens/Messages/message.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ChatRoom extends StatefulWidget{
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final supabase = Supabase.instance.client;
  final chat = ChatApi();
  final stopwatch = Stopwatch();
  final chatSessionDatabase = ChatSessionDatabase();
  final streakDatabase = StreaksDatabase();
  final badgesDatabase = BadgesDatabase();

  final _messageController = TextEditingController();
  bool _isMessageSentToday = false;

  final StreamController<List<Message>> _streamController = StreamController<List<Message>>();
  final List<Message> _messages = [];
  bool _requesting = false;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _messages.add(Message(message: "Hi, it is nice to see you here today", byUser: false));
    _streamController.sink.add(_messages);
    isNewDay();
  }

  void isNewDay() async {
    final userId = supabase.auth.currentUser?.id;
    if(userId == null) return;

    final response = await supabase
      .from('user_streaks')
      .select('last_message_date')
      .eq('id', userId)
      .maybeSingle();

    final now = DateTime.now();

    if(response != null && response['last_message_date'] != null){
      final lastMessageDate = DateTime.parse(response['last_message_date']);

      setState(() {
            _isMessageSentToday =
            lastMessageDate.year == now.year &&
            lastMessageDate.month == now.month &&
            lastMessageDate.day == now.day;
      });
    } else {
      setState(() {
        _isMessageSentToday = false;
      });
    }
  }

  void sendMessage() async{
    final message = _messageController.text.trim();
    _messageController.clear();
    if(message.isNotEmpty){
      if(!_isMessageSentToday){
        //update user streaks after sending message per day
        _updateUserStreaks();
        setState(() {
         
          _isMessageSentToday = true;
        });
      }

      if(!stopwatch.isRunning){
        await chatSessionDatabase.startChatSession();
      }
        setState(() {
            _messages.add(Message(message: message, byUser: true));
            _streamController.sink.add(_messages);
            _requesting = true;
      });
      final botMessage = await chat.createCompletion(message);
        setState(() {
          _requesting = false;
          _messages.add(Message(message: botMessage, byUser: false));
        });

    }
  }

  void endChatSession() async {
    await chatSessionDatabase.endChatSession();
  }

  void _updateUserStreaks() async {
    final userId = supabase.auth.currentUser?.id;
    if(userId != null){
      await streakDatabase.updateUserStreaks(userId);

      final response = await supabase.from('user_streaks')
          .select('counter').eq('id', userId).maybeSingle();

      if (response != null && response['counter'] != null) {
        final counter = response['counter'];
        await badgesDatabase.updateBadgeStatus(counter, userId);

        //check if streak counter matches badge requirement
        if([3,5,7,14,21].contains(counter)){
          await NotificationService().showNotification(
              title: "New Badge 📣",
              body: "You just received a new badge! 🌟"
          );
        } else {
          //update user of their streak count
          await NotificationService().showNotification(
            title: "Streak updated - Keep it up! 🚀",
            body: "You reached $counter days using KaraWell!",
          );
        }
      }
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
          'Chat Room',
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
            endChatSession();
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
            stream: _streamController.stream,
            //UI builder
            builder:  (context, snapshot) {
              //loading
              if(!snapshot.hasData){
                return const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                    )
                  );
              }
              // loaded!
              final messages = snapshot.data!;

         return Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xff027373),
            child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: 
                            ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: messages.length,
                                itemBuilder: (BuildContext context, int index) {
                              return Align(
                                alignment: messages[index].byUser ? Alignment.centerLeft : Alignment.centerRight,
                                child: Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(messages[index].message),
                                  ),
                              ) 
                              );
                            }
                            )

                    ),
                        if(_requesting)
                        const Align(
                          alignment: Alignment.centerRight,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          )
                          ),
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

 



