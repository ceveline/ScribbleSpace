import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'view_profile.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late User user; // Declare user as late to initialize it in initState()
  late String email; // Declare email as late
  late String password;
  final _auth = FirebaseAuth.instance;
  String _newEmail = '';
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    email = user.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ViewProfileScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
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
                // Password
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Text(
                    "Password:",
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
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.transparent)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "*****",
                      fillColor: Colors.white70,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Text(
                    "Re-type password:",
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
                    obscureText: true,
                    controller: _repasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.transparent)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "*****",
                      fillColor: Colors.white70,
                    ),
                  ),
                ),
                Center(
                    child: Container(
                  width: 200,
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      String message = "";
                      // Update email if changed
                      if (_newEmail.isNotEmpty &&
                          _newEmail != _auth.currentUser!.email) {
                        try {
                          // Initiate email update process
                          await _auth.currentUser!
                              .verifyBeforeUpdateEmail(_newEmail);
                          message += "Email update initiated. Check your email for verification link. ";
                          print(
                              "Email update initiated. Check your email for verification link.");
                        } catch (error) {
                          message += "Failed to initiate email update. ";
                          print("Failed to initiate email update: $error");
                          // Handle error (e.g., display error message to the user)
                        }
                      }

                      // Update password if provided
                      if (_passwordController.text.isNotEmpty) {
                        if (_repasswordController.text ==
                            _passwordController.text) {
                          try {
                            // Update password
                            await _auth.currentUser!
                                .updatePassword(_passwordController.text);
                            message += "Password updated successfully";
                            Navigator.pop(context);
                            print("Password updated successfully");
                          } catch (error) {
                            message += "Failed to update password";
                            print("Failed to update password: $error");
                          }
                        } else {
                          message += "Passwords do not match";
                          print("Passwords do not match");
                        }
                      }
                      var snackBar = SnackBar(content: Text(message));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.darkblue),
                  ),
                )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
