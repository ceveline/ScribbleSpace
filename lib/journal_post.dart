import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'journal_page.dart';
import 'edit_journal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateJournalPost extends StatefulWidget {
  final User user;
  final String title;
  final String text;
  final String? id;


  CreateJournalPost({
    required this.user,
    required this.title,
    required this.text,
    this.id,

  });

  @override
  State<StatefulWidget> createState() => _CreateJournalState();
}

class _CreateJournalState extends State<CreateJournalPost> {
  String? date;

  @override
  void initState() {
    super.initState();
    fetchDate().then((value) {
      setState(() {
        date = value;
      });
    });
  }

  Future<String?> fetchDate() async {
    if (widget.id != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('journals')
          .doc(widget.id!)
          .get();
      if (snapshot.exists) {
        // Check if the 'Date' field exists and return it if it does
        if (snapshot.data() != null && snapshot.data()!.containsKey('Date')) {
          return snapshot.data()?['Date'];
        }
      }
    }
    // Return null if document doesn't exist or 'Date' field is not present
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkblue,
      appBar: AppBar(
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JournalPage()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditJournalScreen(
                          documentId: widget.id!,
                          user: widget.user,
                          title: "${widget.title}",
                          text: "${widget.text}")));
            },
            icon: Icon(Icons.edit, color: Colors.white),
          ),
          IconButton(
            iconSize: 30,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // set up the buttons
                    Widget cancelButton = TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    );
                    Widget deleteButton = TextButton(
                      child: Text("Delete"),
                      onPressed: () async {
                        DocumentReference<Map<String, dynamic>> docRef =
                            FirebaseFirestore.instance
                                .collection('journals')
                                .doc(widget.id);

                        await docRef.delete();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JournalPage()));
                      },
                    );
                    return AlertDialog(
                      title: Text('Delete Journal'),
                      content: Text(
                          'Are you sure you want to delete this journal entry?'),
                      actions: [
                        cancelButton,
                        deleteButton,
                      ],
                    );
                  });
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Ensure items stretch horizontally
          children: [
           Container(
             margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
             padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
             color: Colors.white.withOpacity(0.2),
             child:
          Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.title.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

           ),
            // Other content
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                child: Text(
                  '${widget.text}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
              color: Colors.white.withOpacity(0.2),
              child: Text(
                'Date: ${date ??= " "}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
