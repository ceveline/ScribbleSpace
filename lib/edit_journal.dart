import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scribblespace/journal_page.dart';
import 'color_constants.dart';
import 'journal_post.dart';

class EditJournalScreen extends StatefulWidget {
  final String title, text;
  final TextEditingController? titleController;
  final TextEditingController? textController;

  EditJournalScreen({
    required this.title,
    required this.text,
    this.titleController,
    this.textController,
  });
  @override
  State<StatefulWidget> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  late TextEditingController _titleController;
  late TextEditingController _textController;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = widget.titleController ?? TextEditingController(text: widget.title);
    _textController = widget.textController ?? TextEditingController(text: widget.text);
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
              MaterialPageRoute(builder: (context) => CreateJournalPost(title: "${ _titleController.text}", text:"${ _textController.text}")),
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
                  // You can add any additional logic here if needed
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
                  // You can add any additional logic here if needed
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
                          onPressed: () {
                            //Simulate updating database

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
                      SizedBox(height: 20,),
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