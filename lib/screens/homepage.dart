import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/auth/auth_service.dart';
import 'package:myapp/screens/badges/badges_database.dart';
import 'package:myapp/screens/badges/badges_page.dart';
import 'package:myapp/screens/Journal/Journaling_pages.dart';
import 'package:myapp/screens/Journal/journaling_page.dart';
import 'package:myapp/screens/notifications/notification_service.dart';
import 'package:myapp/screens/profile/my_profile.dart';
import 'package:myapp/screens/profile/profile_database.dart';
import 'package:myapp/screens/streaks/streaks_database.dart';
import 'package:myapp/screens/streaks/streaks_page.dart';
import 'package:myapp/screens/chat/chat_room.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  //add audio player
  late AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;

  //call notification service
  final NotificationService notificationService = NotificationService();

  //get auth service
  final authService = AuthService();

  //init supabase
  final supabase = Supabase.instance.client;

  //
  final profileDatabase = ProfileDatabase();
  final streakDatabase = StreaksDatabase();
  final badgesDatabase = BadgesDatabase();

  //when logout button is pressed
  void logout() async {
    await authService.signOut();
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _audioPlayer.setVolume(1.0);
        await _audioPlayer.play(AssetSource('homepage-audio.mp3'));
        print('Audio started playing');
      } catch (e) {
        print('Error playing audio: $e');
      }
    });
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);
    print('App lifecycle state: $state');
    if (state == AppLifecycleState.paused) {
      // App is in the background (home button pressed)
      _audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      _audioPlayer.resume();
    } else if (state == AppLifecycleState.detached) {
      // App is destroyed (back button pressed)
      _audioPlayer.stop();
    }
  }

  void toggleMute() async {
    setState(() {
      _isMuted = !_isMuted;
    });

    await _audioPlayer.setVolume(_isMuted ? 0.0 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xff027373),
        title: StreamBuilder(
            stream: profileDatabase.stream,
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final profile = snapshot.data!.first;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundImage: profile.imageUrl != null
                              ? NetworkImage(profile.imageUrl!)
                              : null,
                          radius: 50,
                          child: profile.imageUrl == null
                              ? Icon(
                            Icons.person,
                            color: Color(0xFFF2F2F2),
                            size: 40,
                          ) : null,
                        ),
                      ),


                      SizedBox(width: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hey, ${profile.username ?? "No username yet."}",
                            style: TextStyle(
                              fontFamily: 'DM_Sans',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF2F2F2),
                            ),
                          ),

                          Text(
                            'Welcome to KaraWell',
                            style: TextStyle(
                              fontFamily: 'DM_Sans',
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),



                ],
              );
            }
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),

        iconTheme: IconThemeData(
          color: Color(0xFFF2F2F2)
        ),
      ),

      body: StreamBuilder(
          stream: CombineLatestStream.combine2(
              streakDatabase.stream,
              badgesDatabase.userBadgeStream,
              (streaks, badges) => {'streaks': streaks, 'badges': badges}),
          builder: (context, snapshot){

            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var data = snapshot.data as Map<String, dynamic>;
            var streaks = data['streaks'] as List;
            var badge = (data['badges'] as List).where((badge) => badge.isUnlocked == true).length;

            var firstStreak = streaks.isNotEmpty ? streaks.first : null;

            return Padding(
              padding: EdgeInsets.all(35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Column(
                    children: [
                      Text(
                        'Progress Tracker',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'DM_Sans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${firstStreak.counter}",
                                    style: TextStyle(
                                      fontFamily: 'DM_Sans',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.local_fire_department_rounded,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Daily Streaks',
                                        style: TextStyle(
                                          fontFamily: 'DM_Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 16),


                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "$badge",
                                    style: TextStyle(
                                      fontFamily: 'DM_Sans',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Badges',
                                        style: TextStyle(
                                          fontFamily: 'DM_Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 50),

                  Column(
                    children: [
                      Text(
                        'What do you want to do today?',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'DM_Sans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),

                      SizedBox(height: 15),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatRoom()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff027373),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.chat_outlined,
                              color: Color(0xFFF2F2F2),
                              size: 25,
                            ),

                            SizedBox(width: 8),

                            Text(
                              'Start new conversation',
                              style: TextStyle(
                                fontFamily: 'DM_Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xfff2f2f2),
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StreaksPage()),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff038C7F),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.accessibility,
                              color: Color(0xFFF2F2F2),
                              size: 25,
                            ),

                            SizedBox(width: 8),

                            Text(
                              'Check your progress',
                              style: TextStyle(
                                fontFamily: 'DM_Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xfff2f2f2),
                              ),

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  Column(
                    children: [
                      Text(
                        "Note what's on your mind!",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'DM_Sans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),

                      SizedBox(height: 10),

                      SizedBox(
                          height: 150,
                          child: ElevatedButton(
                            onPressed: ()  {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => JournalingPages()),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffE3B448),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Opacity(
                                        opacity: 0.8,
                                        child: Image(
                                          image: AssetImage('assets/journal-icon.jpg'),
                                          fit: BoxFit.cover,
                                          width: double.infinity,

                                        ),
                                      )
                                    ),
                                ),

                                SizedBox(height: 20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'My Journals',
                                      style: TextStyle(
                                        fontFamily: 'DM_Sans',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
      ),

      endDrawer: Drawer(
        backgroundColor: Color(0xFFF2F2F2),
        child: StreamBuilder(
            stream: profileDatabase.stream,
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final profile = snapshot.data!.first;

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 250,
                    child: DrawerHeader(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          image: profile.imageUrl != null
                              ? DecorationImage(
                              image: NetworkImage(profile.imageUrl!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken
                              )
                          )
                              : null,
                        ),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                              child: Text(
                                'Welcome, ${profile.username ?? "No username yet."}' ,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DM_Sans',
                                    fontSize: 22.0,
                                    color: profile.imageUrl != null ? Colors.white : Colors.black
                                ),
                              ),
                            )
                        )
                    ),
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 26.0,
                    ),
                    title: const Text(
                      'My Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM_Sans',
                          fontSize: 16.0
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyProfile()),
                      );
                    },
                  ),

                  SizedBox(height: 10),

                  ListTile(
                    leading: Icon(
                      Icons.book,
                      color: Colors.black,
                      size: 26.0,
                    ),
                    title: const Text(
                      'Add Journal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM_Sans',
                          fontSize: 16.0
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JournalingPage(date: DateTime.now(),)),
                      );
                    },
                  ),

                  SizedBox(height: 10),

                  ListTile(
                    leading: Icon(
                      Icons.local_fire_department,
                      color: Colors.black,
                      size: 26.0,
                    ),
                    title: const Text(
                      'Daily Streaks',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM_Sans',
                          fontSize: 16.0
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StreaksPage()),
                      );
                    },
                  ),

                  SizedBox(height: 10),

                  ListTile(
                    leading: Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 26.0,
                    ),
                    title: const Text(
                      'Badges',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM_Sans',
                          fontSize: 16.0
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BadgesPage()),
                      );
                    },
                  ),

                  SizedBox(height: 10),

                  ListTile(
                    onTap: toggleMute,
                    leading: Icon(
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.black,
                      size: 26,
                    ),
                    title: Text(_isMuted ? "Volume Off" : "Volume On",
                      style: TextStyle(
                          fontFamily: "DM_Sans",
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold

                      ),),
                  ),

                  SizedBox(height: 10),

                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Color(0xFFFF3D00),
                      size: 26.0,
                    ),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF3D00),
                          fontFamily: 'DM_Sans',
                          fontSize: 16.0
                      ),
                    ),
                    onTap: logout,
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}



