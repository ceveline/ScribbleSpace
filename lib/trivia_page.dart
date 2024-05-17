import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribblespace/profile_page.dart';
import 'package:scribblespace/trivia_individual_page.dart';
import 'color_constants.dart';
import 'journal_page.dart';
import 'login_screen.dart';
import 'mainmenu_screen.dart';

class TriviaPage extends StatefulWidget {
  const TriviaPage({super.key});

  @override
  State<TriviaPage> createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {


  Future<void> _showTriviaOptionsDialog(BuildContext context, String category) async {
    final TextEditingController _limitController = TextEditingController();
    String selectedDifficulty = 'easy';


    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstants.darkblue,
          title: Text(
            'Trivia Options',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Select the number of questions and difficulty level.',
                  style: TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: _limitController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Number of Questions',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Text("Difficulty", style: TextStyle(color: Colors.white)),
                DropdownButton<String>(
                  key: UniqueKey(), // Add this line to ensure the widget rebuilds
                  value: selectedDifficulty,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedDifficulty = newValue; // Update selectedDifficulty here
                      });
                    }
                  },
                  dropdownColor: ColorConstants.darkblue,
                  items: <String>['easy', 'medium', 'hard']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                int limit = int.tryParse(_limitController.text) ?? 10;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TriviaIndividualPage(
                      category: category,
                      limit: limit,
                      difficulty: selectedDifficulty,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trivia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.darkblue,
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 100,
      ),
      backgroundColor: ColorConstants.purple,
      body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showTriviaOptionsDialog(context, 'Music');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 120,
                  width: MediaQuery.of(context).size.width - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // Shadow color
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 5,
                          // Blur radius
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.my_library_music_sharp,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Music',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showTriviaOptionsDialog(context, 'Film');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 120,
                  width: MediaQuery.of(context).size.width - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // Shadow color
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 5,
                          // Blur radius
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.movie,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Film',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showTriviaOptionsDialog(context, 'Geography');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 120,
                  width: MediaQuery.of(context).size.width - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // Shadow color
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 5,
                          // Blur radius
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.airplane_ticket,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Geography',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showTriviaOptionsDialog(context, 'Society and Culture');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 120,
                  width: MediaQuery.of(context).size.width - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // Shadow color
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 5,
                          // Blur radius
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Society and Culture',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showTriviaOptionsDialog(context, 'Science');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 120,
                  width: MediaQuery.of(context).size.width - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // Shadow color
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 5,
                          // Blur radius
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.science,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Science',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,)
            ],
          ),
      ),
      drawer: Drawer(
        backgroundColor: ColorConstants.darkblue,
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 40,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MainMenuScreen())),
            ),
            SizedBox(
              height: 30,
            ),

            //profile
            ListTile(
              leading: Icon(Icons.person, size: 40, color: Colors.white),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfilePage())),
            ),
            SizedBox(
              height: 30,
            ),

            //trivia
            ListTile(
              leading: Icon(Icons.quiz, size: 40, color: Colors.white),
              title: Text(
                'Trivia',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TriviaPage())),
            ),
            SizedBox(
              height: 30,
            ),

            //journal
            ListTile(
              leading:
              Icon(Icons.menu_book_rounded, size: 40, color: Colors.white),
              title: Text(
                'Journal',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => JournalPage())),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 430,
            ),

            //logout
            ListTile(
              leading: Icon(Icons.logout, size: 40, color: Colors.white),
              title: Text(
                'Logout',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
