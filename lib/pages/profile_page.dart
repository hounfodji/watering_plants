import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watering_plants/components/my_back_button.dart';
import 'package:watering_plants/theme/colors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Profile"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation: 0,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            //loading...
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // error
            else if (snapshot.hasError) {
              return Text("Errors: ${snapshot.error}");
            }

            // data received
            else if (snapshot.hasData) {
              // extract data
              Map<String, dynamic>? user = snapshot.data!.data();

              return Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // back button
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, left: 25.0),
                      child: Row(
                        children: [
                          MyBackButton(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25,),
                    // profile pic
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(24)
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Icon(Icons.person, size: 64,),
                    ),

                    const SizedBox(height: 24,),

                    // username
                    Text(user!["username"], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),

                    const SizedBox(height: 10,),

                    // email
                    Text(user["email"], style: TextStyle(color: Colors.grey[600]),),
                  ],
                ),
              );
            } else {
              return Text("No data");
            }
          }),
    );
  }
}
