import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'color_constants.dart';
import 'package:intl/intl.dart';
import 'view_profile.dart';
import 'mainmenu_screen.dart';
import 'journal_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<String> publicationTitles = [
    "Publication 1",
    "Publication 2",
    "Publication 3",
  ];
  List<String> publicationTexts = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pharetra pharetra massa massa ultricies. Semper eget duis at tellus at. Arcu cursus euismod quis viverra nibh cras pulvinar. Rhoncus dolor purus non enim praesent elementum facilisis leo. Pretium viverra suspendisse potenti nullam ac.",
    "Goodbye",
    "The Beatles",
  ];
  List<Image> publicationImages = [
    Image.asset('assets/profile_picture.png'),
    Image.asset('assets/icon.png'),
    Image.asset('assets/text.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkblue,
      appBar: AppBar(
        backgroundColor: ColorConstants.purple,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                //Purple header
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorConstants.purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      // Adjust the radius as needed
                      bottomRight:
                          Radius.circular(25.0), // Adjust the radius as needed
                    ),
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 120,
                              child: IconButton(
                                icon: Image.asset('assets/profile_picture.png'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ViewProfileScreen()),
                                  );
                                },
                              )
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Trevor Obodoechina',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Positioned(
                  top: 250,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "My Publications",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(

                  width: 350,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: publicationTitles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyPublications(
                          publicationTitles[index],
                          publicationTexts[index],
                              publicationImages[index],
                              () {
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  String content = publicationTexts[index]; // Initialize content with full text
                                  if (publicationTexts[index].length > 80) {
                                    content = publicationTexts[index].substring(0, 80) + "...";
                                  }
                                  return  AlertDialog(
                                    title:  Text('${publicationTitles[index]}'),
                                    content: Text('${content}'),
                                    actions: [
                                      TextButton(onPressed: () {
                                      //Enter logic to view post here
                                      }, child: const Text("View")),
                                      TextButton(onPressed: () {
                                      //Enter logic to edit post here
                                      }, child: const Text("Edit"))
                                    ],
                                  );

                                });
                            // Navigate to EditJournalScreen with publication details

                          }
                      );
                    },
                  ),
                ),
              ],
            )
            // Purple container
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
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainMenuScreen())),
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
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage())),

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
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JournalPage())),

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
              // onTap: ,
            ),
          ],
        ),
      ),
    );
  }
}

GestureDetector MyPublications(String title, String content, Image picture, GestureTapCallback onTap) {
  if(content.length > 80) {
    content = content.substring(0, 75) + "...";
  }
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy/MM/dd kk:mm').format(now);
  return GestureDetector(
    onTap: onTap,
    child: Container(
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25.0),
    ),
    height: 200,
    width: 350,
    child: Stack(
      children: [
        // Image
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 100, // Width of the image
            height: 100, // Height of the image
            child: picture,
          ),
        ),
        // Title and content
        Positioned(
          top: 10,
          left: 110,
          // Adjust this value to position the title next to the image
          child: Container(
           width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8), // Add some space between title and content
                // Content

                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

              ],
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            right: 10,
            child: Text('${formattedDate}',
            style: TextStyle(
              fontSize: 15
            ),))

      ],
    ),
    ),
  );
}
