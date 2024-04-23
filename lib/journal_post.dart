import 'package:flutter/material.dart';
import 'package:scribblespace/create_journal.dart';
import 'color_constants.dart';



class CreateJournalScreen extends StatelessWidget {
  TextEditingController _journalTextController = TextEditingController();
  final String journalTitle;
  CreateJournalScreen({required this.journalTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text('${journalTitle}',
          style: TextStyle(
            color: Colors.white,
          ),),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       TextField(
                        controller: _journalTextController,
                         minLines: 1,
                         maxLines: 20, // and this
                         keyboardType: TextInputType.multiline,
                        readOnly: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.transparent)),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),

            ]),
    ),
   ])
    ),
    );


  }

}