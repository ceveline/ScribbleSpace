import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'journal_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateJournalScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateJournalScreenState();

}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  String? title, text;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.purple,
        appBar: AppBar(
          title: Text('Create Journal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
            ),
          ), leading: IconButton(
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
          backgroundColor: ColorConstants.darkblue,
          toolbarHeight: 80,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: "Title",),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 2,
                      onChanged: (val) {
                        title = val;
                      },
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),


                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(hintText: "Your text"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                          fontSize: 20
                      ),
                      onChanged: (val) {
                        text = val;
                      },
                    ),
                    SizedBox(height: 50),
                    Center(
                      child:
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.darkblue,
                      ),
                      child: TextButton(
                          onPressed: () {
                            if (title != null && text != null) {
                              firestore.collection("journals").add({
                                "Title": title,
                                "Text": text,
                                "User": FirebaseAuth.instance.currentUser?.email.toString(),
                              });
                            }

                          },
                          child: Text('Save', style: TextStyle(
                              color: Colors.white, fontSize: 20),)
                      ),
                    ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
        );
  }

}