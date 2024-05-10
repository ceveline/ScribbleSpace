import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'color_constants.dart';
import 'package:intl/intl.dart';
import 'view_profile.dart';
import 'mainmenu_screen.dart';
import 'journal_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'individual_publication_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user; // Declare user as late to initialize it in initState()
  late String email; // Declare email as late
  List<String> publicationTitles = [];
  List<String> publicationTexts = [];
  List<String> publicationImageUrls = [];
  List<Image> publicationImages = [
    Image.asset('assets/profile_picture.png'),
    Image.asset('assets/icon.png'),
    Image.asset('assets/text.png'),
  ];
  List<String> publicationCategory1 = [];
  List<String> publicationCategory2 = [];

  @override
  void initState() {
    super.initState();
    // Initialize user and email in initState()
    user = FirebaseAuth.instance.currentUser!;
    email = user.email ?? "";
    fetchPublications();
  }

  void fetchPublications() async {
    // Query Firestore for publications
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('publications')
        .where('User', isEqualTo: email)
        .get();

    // Extract publication data from snapshot and populate lists
    snapshot.docs.forEach((doc) {
      var data = doc.data();
      publicationTitles.add(data['Title']);
      publicationTexts.add(data['Text']);
      publicationImageUrls.add(data['Image']);
      publicationCategory1.add(data['Category-1']);
      publicationCategory2.add(data['Category-2']);
    });

    // Update UI after fetching data
    setState(() {});
  }

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
                    itemCount: publicationTitles.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PublicationWidget(
                        user: user,
                        title: publicationTitles[index],
                        text: publicationTexts[index],
                        imageUrl: publicationImageUrls[index],
                        category1: publicationCategory1[index],
                        category2: publicationCategory2[index],
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
              // onTap: ,
            ),
          ],
        ),
      ),
    );
  }
}

class PublicationWidget extends StatelessWidget {
  final User user;
  final String title;
  final String text;
  final String imageUrl;
  final String? category1;
  final String? category2;

  PublicationWidget({
    required this.user,
    required this.title,
    required this.text,
    required this.imageUrl,
    this.category1,
    this.category2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)
          => IndividualPubPage(title: title,
            text: text, image: imageUrl, user: user.email,
            category1: category1, category2: category2,
          )));
    },
    child: Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
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
          ClipRRect(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.width / 2.7,
              width: MediaQuery.of(context).size.width / 3,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "${(text.length > 100) ? text.toString().substring(0, 90) : text.toString()}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (category1 != "none")
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.darkblue,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        category1!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  SizedBox(height: 5),
                  if (category2 != "none")
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.darkblue,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        category2!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                          )
                      ]),

              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
