import 'package:flutter/material.dart';
import 'package:scribblespace/login_screen.dart';
import 'color_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text('Create Account', style: TextStyle(
          color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold
        ),),
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 80,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }, 
          icon: Icon(Icons.arrow_back_ios), color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  //username
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Text(
                      "Username:",
                      style: TextStyle(fontSize: 20, color: Colors.white,
                          fontWeight: FontWeight.bold),
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

                  //email
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Text(
                      "Email:",
                      style: TextStyle(fontSize: 20, color: Colors.white,
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
                        hintText: "jondoe123@gmail.com",
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),

                  // Password
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Text(
                      "Password:",
                      style: TextStyle(fontSize: 20, color: Colors.white,
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
                        hintText: "••••••••",
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),

                  //login button
                  Center(
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text)
                                .then((value) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold,
                                color: ColorConstants.purple),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.darkblue),
                        ),
                      )),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
