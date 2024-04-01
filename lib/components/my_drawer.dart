import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watering_plants/theme/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // logout method
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header
          DrawerHeader(child: Icon(Icons.favorite, color: secondaryColor,)),

          const SizedBox(height: 25,),
          // home tile
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: Icon(Icons.home,),
              title: Text("H O M E"),  
              onTap: () {
                // this is already the home page so just pop drawer
                Navigator.pop(context);
              },
          
            ),
          ),

          // profile tile
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: Icon(Icons.person,),
              title: Text("P R O F I L E"),  
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // navigate to profile page
                Navigator.pushNamed(context, "/profile_page");
              },
          
            ),
          ),

         
            ],
          ),

          // logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.home,),
              title: Text("L O G O U T"),  
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // logout
                logout();
              },
          
            ),
          ),
        ],
      ),
    );
  }
}