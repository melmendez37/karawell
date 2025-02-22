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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xffffffff),
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
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final badges = snapshot.data!;

           return ListView.builder(
             itemCount: badges.length,
               itemBuilder: (context, index){
                  final userBadge = badges[index];



                  return FutureBuilder<Badges?>(
                      future: badgesDatabase.fetchBadge(userBadge.badgeId),
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

                        final badge = badgeSnapshot.data!;
                        final isUnlocked = userBadge.isUnlocked;

                        return ListTile(
                          leading: ColorFiltered(
                              colorFilter: isUnlocked ? ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                                  : ColorFilter.mode(Colors.grey, BlendMode.saturation),
                            child: Image.network(
                                badge.imageUrl,
                                width: 50,
                                height: 50,
                            ),
                          ),
                          title: Text(
                              badge.name,
                              style: TextStyle(
                                  fontFamily: 'DM_Sans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),

                          ),
                          subtitle: Text(
                              isUnlocked ? "Unlocked" : "Locked",
                              style: TextStyle(
                                fontFamily: 'DM_Sans',
                                fontSize: 16,
                                fontStyle: FontStyle.italic
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



