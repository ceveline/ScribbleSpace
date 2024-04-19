import 'package:flutter/material.dart';
import 'color_constants.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        //use an api for time of the day, create a method for it
        title: Text('Hello, jondoe!\nGood morning', style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 100,

      ),
      drawer: Drawer(
        backgroundColor: ColorConstants.darkblue,
        child: ListView(
          children: [
            SizedBox(height: 30,),
            ListTile(
              leading: Icon(Icons.home, size: 40, color: Colors.white,),
              title: Text('Home', style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
            ),
            SizedBox(height: 30,),

            //profile
            ListTile(
              leading: Icon(Icons.person, size: 40, color: Colors.white),
              title: Text('Profile', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
            ),
            SizedBox(height: 30,),

            //trivia
            ListTile(
              leading: Icon(Icons.quiz, size: 40, color: Colors.white),
              title: Text('Trivia', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
            ),
            SizedBox(height: 30,),

            //journal
            ListTile(
              leading: Icon(Icons.menu_book_rounded, size: 40, color: Colors.white),
              title: Text('Journal', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height - 430,),

            //logout
            ListTile(
              leading: Icon(Icons.logout, size: 40, color: Colors.white),
              title: Text('Logout', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
              // onTap: ,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(

      ),
    );
  }
}
