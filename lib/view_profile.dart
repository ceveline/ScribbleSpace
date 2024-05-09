import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'edit_profile.dart';
import 'profile_page.dart';
import 'journal_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ViewProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  late User user; // Declare user as late to initialize it in initState()
  late String email; // Declare email as late
  late String password;

  @override
  void initState() {
    super.initState();
    // Initialize user and email in initState()
    user = FirebaseAuth.instance.currentUser!;
    email = user.email ?? "";
  }

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text(
          'View Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              iconSize: 40,
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 90, 10, 10),
              height: 250,
              width: 250,
              child: Image.asset(
                'assets/white_icon.png',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                ),
                // Email
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Text(
                    "Email:",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: 340,
                  height: 70,
                  child: TextField(
                    readOnly: true,
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.transparent)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "${email}",
                      fillColor: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
