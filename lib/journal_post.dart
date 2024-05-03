
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scribblespace/create_journal.dart';
import 'color_constants.dart';
import 'journal_page.dart';
import 'edit_journal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateJournalPost extends StatefulWidget {
  final User user;
  final String title;
  final String text;
  final TextEditingController? titleController;
  final TextEditingController? textController;

  CreateJournalPost({
    required this.user,
    required this.title,
    required this.text,
    this.titleController,
    this.textController,
  });

  @override
  State<StatefulWidget> createState() => _CreateJournalState();
}

class _CreateJournalState extends State<CreateJournalPost> {
  late TextEditingController _titleController;
  late TextEditingController _textController;
  var data;
  String documentId = '';
  void fetchJournal() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('journals')
        .where('User', isEqualTo: widget.user.email)
        .get();

    // Extract publication data from snapshot and populate lists
    snapshot.docs.forEach((doc) {
      data = doc.data();
       documentId = doc.id; // Retrieve the document ID
    });
  }
  @override
  void initState() {
    super.initState();
    _titleController =
        widget.titleController ?? TextEditingController(text: widget.title);
    _textController =
        widget.textController ?? TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: ColorConstants.purple,
          appBar: AppBar(
            title: Text(
              '${_titleController.text}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EditJournalScreen(documentId: documentId, user: widget.user,  title: "${ _titleController.text}", text:"${ _textController.text}"))
                  );},
                icon: Icon(Icons.edit, color: Colors.white),
              ),
              IconButton(
                iconSize: 30,
                onPressed: () {
                  // Add logic for delete/garbage action
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),

            ],
          ),
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Text(
              '${_textController.text}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ])),
    );
  }
}
