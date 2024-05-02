import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 90, 10, 10),
              child: Image.asset(
                'assets/text.png',
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                  ),
                  //username
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
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text).then((value){
                          print('Signing in');
                        }).onError((error, stackTrace){
                          print('Error: ${error.toString()}');
                        });
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold,
                        color: ColorConstants.purple),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: ColorConstants.darkblue),
                    ),
                  )),

                  //register text button
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => RegistrationScreen()),
                            );
                          },
                          child: Text(
                            'Don\'t have an account? Register now!',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,
                            color: ColorConstants.darkblue),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
