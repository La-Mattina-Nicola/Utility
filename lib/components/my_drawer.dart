import 'package:flutter/material.dart';
import 'package:utility/Pages/calendar_page.dart';
import 'package:utility/Pages/games/games_page.dart';
import 'package:utility/Pages/games/test_page.dart';
import 'package:utility/services/auth/auth_service.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _auth = AuthService();
  
  void logout() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 150,
                padding: const EdgeInsets.only(top: 45),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 64,
                      ),
                      Text(_auth.getCurrentUser()!.email.toString()),
                    ],
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: const Text("H O M E  &  M E S S A G E", style: TextStyle(fontSize: 15),),
                  leading: Icon(Icons.home, color: Theme.of(context).colorScheme.tertiary),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: const Text("C A L E N D A R", style: TextStyle(fontSize: 15),),
                  leading: Icon(Icons.calendar_month, color: Theme.of(context).colorScheme.tertiary,),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarPage(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: const Text("C A R D S", style: TextStyle(fontSize: 15),),
                  leading: Icon(Icons.search, color: Theme.of(context).colorScheme.tertiary,),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: const Text("G A M E S", style: TextStyle(fontSize: 15),),
                  leading: Icon(Icons.gamepad_outlined, color: Theme.of(context).colorScheme.tertiary,),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => const GamesPage(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: const Text("T E S T", style: TextStyle(fontSize: 15),),
                  leading: Icon(Icons.bug_report_outlined, color: Theme.of(context).colorScheme.tertiary,),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => DragDropGridView(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: const Text("S E T T I N G S", style: TextStyle(fontSize: 15),),
                  leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.tertiary,),
                  onTap: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: ListTile(
              title: const Text("L O G O U T", style: TextStyle(fontSize: 15),),
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.tertiary,),
              onTap: logout,
            ),
          ),
        ],
      )
    );
  }
}