import 'package:flutter/material.dart';
import 'package:scribblespace/create_journal.dart';
import 'color_constants.dart';
import 'journal_page.dart';
import 'edit_journal.dart';

class CreateJournalPost extends StatefulWidget {
  final String title;
  final String text;
  final TextEditingController? titleController;
  final TextEditingController? textController;

  CreateJournalPost({
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
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EditJournalScreen(title: "${ _titleController.text}", text:"${ _textController.text}"))
                  );},
                icon: Icon(Icons.edit, color: Colors.white),
              ),
              IconButton(
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
