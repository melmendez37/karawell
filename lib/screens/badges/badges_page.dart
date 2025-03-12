import 'package:flutter/material.dart';
import 'package:myapp/screens/badges/badges_database.dart';
import 'package:myapp/screens/badges/user_badges.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'badges.dart';

class BadgesPage extends StatefulWidget {
  const BadgesPage({super.key});

  @override
  State<BadgesPage> createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  final supabase = Supabase.instance.client.auth.currentUser?.id;

  final badgesDatabase = BadgesDatabase();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xfff2f2f2),
        title: Text(
          'Badges',
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

      body: StreamBuilder<List<UserBadges>>(
          stream: badgesDatabase.userBadgeStream,
          builder: (context, userBadgeSnapshot){
            if(!userBadgeSnapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final userBadges = userBadgeSnapshot.data!;

            return FutureBuilder<List<Badges>>(
               future: badgesDatabase.fetchAllBadges(),
               builder: (context, badgeSnapshot){
                 if(badgeSnapshot.connectionState == ConnectionState.waiting){
                   return ListTile(
                     title: Text('loading...'),
                     leading: CircularProgressIndicator(),
                   );
                 }

                 if(badgeSnapshot.hasError || badgeSnapshot.data == null){
                   return ListTile(
                     title: Text('no badge BRUH.'),
                   );
                 }

                 final allBadges = badgeSnapshot.data!;
                 final badgeMap = {for (var badge in allBadges) badge.id: badge};

                 if (userBadges.isEmpty) {
                   return const Center(
                     child: Text("You haven't earned any badges yet."),
                   );
                 }

                 return ListView.builder(
                     itemCount: userBadges.length,
                     itemBuilder: (context, index){

                       final userBadge = userBadges[index];
                       final badge = badgeMap[userBadge.badgeId];

                       if (badge == null) {
                         return const ListTile(
                           title: Text('Badge not found.'),
                           subtitle: Text('This badge no longer exists.'),
                         );
                       }

                       final isUnlocked = userBadge.isUnlocked;

                       return Padding(
                           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Container(
                              height: 100,
                              //padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isUnlocked ? Color(0XFFF2F2F2) : Color(0XFFF2F2F2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20), // Adjust horizontal padding
                                  leading: ColorFiltered(
                                    colorFilter: isUnlocked ? ColorFilter.mode(Colors.transparent, BlendMode.dst)
                                        : ColorFilter.mode(Colors.grey, BlendMode.saturation),
                                    child: Image.network(
                                      badge.imageUrl,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  title: Text(
                                    badge.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'DM_Sans',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),

                                  ),
                                  subtitle: Text(
                                    isUnlocked ? "Unlocked at ${badge.unlockAt}" : "Keep going to unlock at ${badge.unlockAt} days!",
                                    style: TextStyle(
                                        fontFamily: 'DM_Sans',
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  tileColor: isUnlocked ? Colors.transparent : Colors.white,
                                ),
                              ),

                            ),
                       );

                     }
                 );
               }
           );
          }
      )
    );
  }
}



