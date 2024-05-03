import 'package:flutter/material.dart';
import 'package:scribblespace/create_post_screen.dart';
import 'package:scribblespace/login_screen.dart';
import 'package:scribblespace/publication_page.dart';
import 'color_constants.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainMenuScreen extends StatelessWidget {

  const MainMenuScreen({super.key});

  Container _buildContainer(Icon icon, String title, double screenSize) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 100,
      width: screenSize - 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color:
            ColorConstants.darkblue, // You can customize the default color here
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeFormatter = DateFormat('HH:mm:ss');
    final email = FirebaseAuth.instance.currentUser?.email.toString();

    String _greetingMessage() {
      final DateTime now = DateTime.now();
      final currentTime = timeFormatter.format(now);
      final currentHour = int.parse(currentTime.split(':')[0]);

      if (currentHour >= 0 && currentHour < 12) {
        return "Good morning";
      } else if (currentHour >= 12 && currentHour < 18) {
        return "Good afternoon";
      } else {
        return "Good evening";
      }
    }

    return Scaffold(
      backgroundColor: ColorConstants.purple,
      floatingActionButton: FloatingActionButton.large(
        elevation: 5,
        backgroundColor: ColorConstants.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
      ),
      appBar: AppBar(
        //use an api for time of the day, create a method for it
        title: Text(
          'Hello, ${email?.substring(0, email?.indexOf('@'))}!\n${_greetingMessage()}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 100,
        iconTheme: IconThemeData(color: Colors.white),
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
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Text(
                'What\'s orbitting in your mind today? ⭑☽',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 120,
                    width: MediaQuery.of(context).size.width - 25,
                    // color: ColorConstants.darkblue,
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
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.cloud_circle,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Everything',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PublicationPage(category: 'Entertainment',)));
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
                            'Entertainment',
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PublicationPage(category: 'Food',)));
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
                            Icons.restaurant,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Food',
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PublicationPage(category: 'Health & Wellness',)));
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
                            Icons.spa_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Health & Wellness',
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PublicationPage(category: 'Sports',)));
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
                            Icons.sports_basketball,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Sports',
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PublicationPage(category: 'Technology',)));
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
                            Icons.computer,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Technology',
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PublicationPage(category: 'Travel',)));
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
                            Icons.airplanemode_on_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Travel',
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PublicationPage(category: 'Pets & Animals',)));
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
                            Icons.pets,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Pets & Animals',
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
                  )
                ],
              )),
            ],
          )),
    );
  }
}
