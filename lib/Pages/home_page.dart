import 'package:flutter/material.dart';
import 'package:utility/Pages/chat_page.dart';
import 'package:utility/components/my_Drawer.dart';
import 'package:utility/components/usertile.dart';
import 'package:utility/services/auth/auth_service.dart';
import 'package:utility/services/chat/chat_service.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wb_sunny_outlined, size: 40),
              Icon(Icons.cloud_outlined, size: 40),
              Icon(Icons.thunderstorm_outlined, size: 40),
              Icon(Icons.snowing, size: 40),
              Icon(Icons.ac_unit_rounded, size: 40),
              Icon(Icons.air, size: 40),
              Icon(Icons.bedtime_outlined, size: 40),
            ],
          ),
          const Text("M E T E O"),
          const Column(
            children: [
              Text("LOCATIONS : CHARLEROI"),
            ],
          ),
           Column(
            children: [
              const SizedBox(height: 20,),
              const Text("TODAY"),
              Container(
                padding: const EdgeInsets.all(20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("15°C", style: TextStyle(fontSize: 30),),
                    Icon(Icons.wb_sunny_outlined, size: 40),
                  ],
                ),
              ),
              const Text("TOMORROW"),
              Container(
                padding: const EdgeInsets.all(20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("15°C", style: TextStyle(fontSize: 30),),
                    Icon(Icons.cloud_outlined, size: 40)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(child: _buildUserList(),)
          
        ],
      ),
      
      
    );
  }


  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const Text("Error");
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      }
    );
  }
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if(userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"], 
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
