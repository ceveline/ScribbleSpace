import 'package:flutter/material.dart';
import 'package:scribblespace/create_journal.dart';
import 'color_constants.dart';



class CreateJournalScreen extends StatelessWidget {
 // final String journalTitle;
  //CreateJournalScreen({required this.journalTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text('test',
          style: TextStyle(
            color: Colors.white,
          ),),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20),
                child:
              Container(
                child: Text(

                  'hello',
                  style: TextStyle(
                      fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
                ),
              ),
              ),
   ])
    ),
    );


  }

}