
import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'view_profile.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();

}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text('Edit Profile',
        style: TextStyle(
        color: Colors.white,
        fontSize: 27,
    ),),
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
        child: Stack(
          children: [
            Center( child:
            Container(padding: EdgeInsets.fromLTRB(10, 90, 10, 10),
              height: 250,
              width: 250,
              child: Image.asset(
                'assets/profile_picture.png',
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
            //username
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Text(
                "Username:",
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: 340,
              height: 70,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "jondoe123",
                  fillColor: Colors.white70,
                ),
              ),
            ),

            // Password
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Text(
                "Password:",
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
            // Email
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Text(
                "Email:",
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: 340,
              height: 70,
              child: TextField(
                obscureText: true,
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "doe123@gmail.com",
                  fillColor: Colors.white70,
                ),
              ),
            ),
            Center(
                child: Container(
                  width: 200,
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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