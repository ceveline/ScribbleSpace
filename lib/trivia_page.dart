import 'package:flutter/material.dart';
import 'package:scribblespace/trivia_individual_page.dart';
import 'color_constants.dart';
import 'mainmenu_screen.dart';

class TriviaPage extends StatefulWidget {
  const TriviaPage({super.key});

  @override
  State<TriviaPage> createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenuScreen()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
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
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TriviaIndividualPage(category: 'Music',)));
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
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => PublicationPage(category: 'Entertainment',)));
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
                  // Navigator.push(context, MaterialPageRoute(
                      // builder: (context) => PublicationPage(category: 'Entertainment',)));
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
                        'Animal',
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
                  // Navigator.push(context, MaterialPageRoute(
                      // builder: (context) => PublicationPage(category: 'Entertainment',)));
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
                        Icons.star,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Celebrities',
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
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => PublicationPage(category: 'Entertainment',)));
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
                        Icons.sports_baseball,
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
              SizedBox(height: 15,)
            ],
          ),
      ),

    );
  }
}
