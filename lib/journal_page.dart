import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'color_constants.dart';
import 'package:intl/intl.dart';
import 'create_journal.dart';
import 'edit_journal.dart';
import 'journal_post.dart';
import 'view_profile.dart';

class JournalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  TextEditingController _searchController = TextEditingController();

  // Dummy code this will be retrieved from firebase
  List<String> publicationTitles = [
    "Publication 1",
    "Publication 2",
    "Publication 3",
  ];
  List<String> publicationTexts = [
    "Hello",
    "Goodbye",
    "The Beatles",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        elevation: 5,
        backgroundColor: ColorConstants.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateJournalScreen()),
          );
        },
      ),
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
                                  icon:
                                      Image.asset('assets/profile_picture.png'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewProfileScreen()),
                                    );
                                  },
                                )),
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
                      child: Column(
                        children: [
                          Text(
                            "My Journal",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 350,
                            height: 50,
                            child: SearchAnchor(
                              builder: (BuildContext context,
                                  SearchController controller) {
                                return TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onSubmitted: (String query) {
                                    // Find the index of the query in publicationTitles
                                    int index =
                                        publicationTitles.indexOf(query);
                                    if (index != -1) {
                                      // Show the AlertDialog
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              '${publicationTitles[index]}'),
                                          content: Text(
                                              '${publicationTexts[index]}'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreateJournalPost(
                                                      title: publicationTitles[
                                                          index],
                                                      text: publicationTexts[
                                                          index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text("View"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditJournalScreen(
                                                      title: publicationTitles[
                                                          index],
                                                      text: publicationTexts[
                                                          index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text("Edit"),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      if (_searchController.text.isEmpty) {
                                        showInSnackBar(
                                            context, "Search is empty");
                                      } else {
                                        showInSnackBar(context,
                                            "${_searchController.text} does not exist");
                                      }
                                    }
                                  },
                                );
                              },
                              suggestionsBuilder: (BuildContext context,
                                  SearchController controller) {
                                return List<Widget>.generate(
                                    publicationTitles.length, (int index) {
                                  final String title = publicationTitles[index];
                                  return ListTile(
                                    title: Text(title),
                                    onTap: () {
                                      setState(() {
                                        controller.closeView(title);
                                      });
                                    },
                                  );
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  width: 350,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: publicationTitles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyPublications(
                          publicationTitles[index], publicationTexts[index],
                          () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateJournalPost(
                                      title: publicationTitles[index],
                                      text: publicationTexts[index],
                                    )));
                      });
                      // Navigate to EditJournalScreen with publication details
                    },
                  ),
                ),
              ],
            ),
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
              // onTap: ,
            ),
          ],
        ),
      ),
    );
  }
}

void showInSnackBar(BuildContext context, String value) {
  var snackBar = SnackBar(content: Text(value));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

GestureDetector MyPublications(
    String title, String text, GestureTapCallback onTap) {
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
      height: 120,
      width: 350,
      child: Stack(
        children: [
          // Image

          // Title and content
          Positioned(
            top: 10,
            left: 10,
            // Adjust this value to position the title next to the image
            child: Container(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              '${formattedDate}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
