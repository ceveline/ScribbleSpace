import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scribblespace/journal_page.dart';
import 'color_constants.dart';
import 'journal_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditJournalScreen extends StatefulWidget {
  final User user;
  final String title;
  final String text;
  final String documentId; // Add document ID parameter

  EditJournalScreen({
    required this.user,
    required this.title,
    required this.text,
    required this.documentId, // Initialize document ID
  });

  @override
  State<StatefulWidget> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  late TextEditingController _titleController;
  late TextEditingController _textController;


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _textController = TextEditingController(text: widget.text);
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
          'Edit Journal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CreateJournalPost(
                  user: widget.user,
                  title: _titleController.text,
                  text: _textController.text,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 2,
                onChanged: (val) {
                  // Update the title text
                },
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "Text",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: 20),
                onChanged: (val) {
                  // Update the text
                },
              ),
              Center(
                child: Container(
                  width: 300,
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (_titleController.text.isNotEmpty) {
                              try {
                                // Get the document reference for the current user's journal entry
                                DocumentReference<Map<String, dynamic>> docRef =
                                FirebaseFirestore.instance
                                    .collection('journals')
                                    .doc(widget.documentId);

                                // Update the 'Text' field of the document
                                await docRef.update({
                                  'Title': _titleController.text,
                                });

                                print("Journal entry updated successfully");
                              } catch (error) {
                                print("Failed to update journal entry: $error");
                              }
                            }
                            if (_textController.text.isNotEmpty) {
                              try {
                                // Get the document reference for the current user's journal entry
                                DocumentReference<Map<String, dynamic>> docRef =
                                FirebaseFirestore.instance
                                    .collection('journals')
                                    .doc(widget.documentId);

                                // Update the 'Text' field of the document
                                await docRef.update({
                                  'Text': _textController.text
                                });

                                print("Journal entry updated successfully");
                              } catch (error) {
                                print("Failed to update journal entry: $error");
                              }
                            }
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.darkblue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.darkblue,
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Handle delete button press
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
