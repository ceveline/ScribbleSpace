import 'package:flutter/material.dart';
import 'color_constants.dart';

class CreateJournalScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateJournalScreenState();

}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _journalTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text('Create Journal',
          style: TextStyle(
            color: Colors.white,
          ),),
      ),
      body: SingleChildScrollView(
        child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //username
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: Text(
                        "Title:",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      width: 340,
                      height: 70,
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.transparent)),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),

                    // Password
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 5),
                      child: Text(
                        "Text:",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      width: 340,
                      child: TextField(

                        controller:  _journalTextController,
                        minLines: 10, // Set this
                        maxLines: 20, // and this
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.transparent)),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                    // Email

                    Center(
                        child: Container(
                          width: 200,
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorConstants.darkblue),
                                ),
                          ),
                        ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

}