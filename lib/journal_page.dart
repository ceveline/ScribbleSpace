import 'dart:async';
import 'trivia_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'color_constants.dart';
import 'create_journal.dart';
import 'journal_post.dart';
import 'profile_page.dart';
import 'mainmenu_screen.dart';
import 'view_profile.dart';
import 'login_screen.dart';

class JournalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  late User user; // Declare user as late to initialize it in initState()
  late String email; // Declare email as late

  TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  List<String> publicationTitles = [];
  List<String> publicationTexts = [];
  List<dynamic> publicationIds = [];

  @override
  void initState() {
    super.initState();
    // Initialize user and email in initState()
    user = FirebaseAuth.instance.currentUser!;
    email = user.email ?? "";
    fetchJournal();
  }

  void fetchJournal() async {
    // Query Firestore for Journals
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('journals')
        .where('User', isEqualTo: email)
        .get();

    // Extract publication data from snapshot and populate lists
    snapshot.docs.forEach((doc) {
      var data = doc.data();
      publicationTitles.add(data['Title']);
      publicationTexts.add(data['Text']);
      publicationIds.add(doc.id);
    });
    // Update UI after fetching data
    setState(() {});
  }

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
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        backgroundColor: ColorConstants.darkblue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/journal_back.png'),
                      // Replace with your image asset path
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
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
                                  icon: Image.asset('assets/white_icon.png'),
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
                                '${email?.substring(0, email?.indexOf('@'))}',
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
                    width: MediaQuery.of(context).size.width - 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
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
                                  onChanged: (String query) {
                                    setState(() {
                                      _searchQuery = query;
                                    });
                                  },
                                  onSubmitted: (String query) {
                                    query = _searchController.text;

                                    query.toLowerCase();
                                    // Find the index of the query in publicationTitles
                                    int index = publicationTitles.indexWhere(
                                        (title) =>
                                            title.toLowerCase() == query);
                                    if (index != -1) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateJournalPost(
                                            user: user,
                                            title: publicationTitles[index],
                                            text: publicationTexts[index],
                                            id: publicationIds[index],
                                          ),
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
                                return Future.value(
                                  ListView(
                                    children: publicationTitles.map((title) {
                                      return ListTile(
                                        title: Text(title),
                                        onTap: () {
                                          _searchController.text = title;
                                          controller.closeView(title);
                                        },
                                      );
                                    }).toList(),
                                  ) as FutureOr<Iterable<Widget>>?,
                                );
                              },
                              viewLeading: SizedBox(
                                height: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "My Journals",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  width: MediaQuery.of(context).size.width - 5,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: publicationTitles.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Check if the title matches the query from the beginning
                        bool matchesSearch = publicationTitles[index]
                            .toLowerCase()
                            .startsWith(_searchQuery.toLowerCase());

                        return matchesSearch
                            ? JournalWidget(
                                user: user,
                                title: publicationTitles[
                                    index], // Format the title
                                text: publicationTexts[index],
                                id: publicationIds[index],
                              )
                            : Container();
                      }),
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

Widget formatTitle(String title, String query) {
  // Index of the matching part of the title, -1 if not found
  int index = title.toLowerCase().indexOf(query.toLowerCase());

  if (index != -1) {
    // Matching part of the title
    String matchingPart = title.substring(index, index + query.length);
    // Before and after parts of the title
    String beforePart = title.substring(0, index);
    String afterPart = title.substring(index + query.length);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: beforePart,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: matchingPart,
            style: TextStyle(
              backgroundColor: Colors.grey,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: afterPart,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  } else {
    // If no match found, simply display the title
    return Text(
      title,
      style: TextStyle(color: Colors.white),
    );
  }
}

void showInSnackBar(BuildContext context, String value) {
  var snackBar = SnackBar(content: Text(value));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class JournalWidget extends StatelessWidget {
  final User user;
  final String title;
  final String text;
  final String id;
  final String? query;

  JournalWidget({
    required this.user,
    required this.title,
    required this.text,
    required this.id,
    this.query,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateJournalPost(
              title: title,
              text: text,
              user: user,
              id: id,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorConstants.darkblue,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (query != null) // Check if query is not null
                    formatTitle(title, query!), // Use the formatted title here
                  SizedBox(height: 5),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${(text.length > 100) ? text.toString().substring(0, 90) : text.toString()}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
