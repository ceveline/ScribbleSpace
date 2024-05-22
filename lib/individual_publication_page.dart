import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scribblespace/like_button.dart';
import 'color_constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'edit_publication.dart';
import 'mainmenu_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class IndividualPubPage extends StatefulWidget {
  final String? postId;
  final List<String>? likes;
  final String? title;
  final String? text;
  final String? user;
  final String? image;
  final String? category1;
  final String? category2;
  final String? docId;

  const IndividualPubPage({
    this.title,
    this.text,
    this.image,
    this.user,
    this.category1,
    this.category2,
    this.docId,
    this.likes,
    this.postId
  });

  @override
  State<IndividualPubPage> createState() => _IndividualPubPageState();
}

class _IndividualPubPageState extends State<IndividualPubPage> {

  //get user from fb
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.likes != null && currentUser != null) {
      isLiked = widget.likes!.contains(currentUser!.email);
    }
  }

  // void toggleLike() {
  //   setState(() {
  //     isLiked = !isLiked;
  //   });
  //
  //   DocumentReference postRef = FirebaseFirestore.instance.collection('publications').doc(widget.postId);
  //
  //   if (isLiked) {
  //     postRef.update({
  //       'Likes': FieldValue.arrayUnion([currentUser.email])
  //     });
  //   } else {
  //     postRef.update({
  //       'Likes': FieldValue.arrayRemove([currentUser.email])
  //     });
  //   }
  // }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Update likes in Firestore
      DocumentReference postRef =  FirebaseFirestore.instance.collection('publications').doc(widget.postId);
    if (isLiked) {
        postRef.update({
          'Likes': FieldValue.arrayUnion([currentUser!.email])
        });
      } else {
        postRef.update({
          'Likes': FieldValue.arrayRemove([currentUser!.email])
        });
      }

  }




  @override
Widget build(BuildContext context) {
  bool isCurrentUser = currentUser.email == widget.user; // Check if current user's email matches publication's user
  print(' doc: ${widget.docId}');
  return Scaffold(
    backgroundColor: ColorConstants.darkblue,
    appBar: AppBar(
      backgroundColor: ColorConstants.darkblue,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      actions: [
        Visibility(
          visible: isCurrentUser, // Show only if the current user matches the publication's user
          child: IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPostScreen(
                    title: "${widget.title}",
                    text: "${widget.text}",
                    user: widget.user,
                    image: "${widget.image}",
                    category1: "${widget.category1}",
                    category2: "${widget.category2}",
                    docId: "${widget.docId}",
                  ),
                ),
              );
              print("${widget.category1}");
              print("${widget.category2}");
            },
            icon: Icon(Icons.edit, color: Colors.white),
          ),
        ),
        Visibility(
          visible: isCurrentUser, // Show only if the current user matches the publication's user
          child: IconButton(
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
                      print('${widget.docId}');
                      DocumentReference<Map<String, dynamic>> docRef =
                      FirebaseFirestore.instance
                          .collection('publications')
                          .doc(widget.docId);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainMenuScreen()),
                      );
                      await docRef.delete();

                    },
                  );
                  return AlertDialog(
                    title: Text('Delete Publication'),
                    content: Text(
                        'Are you sure you want to delete this publication?'),
                    actions: [
                      cancelButton,
                      deleteButton,
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ],
    ),

    body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    widget.image.toString(),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  color: Colors.black.withOpacity(0.25),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 100,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      widget.title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //like button
                LikeButton(isLiked: isLiked, onTap: toggleLike
                ),
                const SizedBox(height: 5,),

                //like count

                Text(
                  ' ${widget.likes != null ? widget.likes!.length.toString() : '0'}',
                  style: TextStyle(color: Colors.white),
                ),
                //count
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: ColorConstants.darkblue,
              child: Text(
                widget.text.toString(),
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
              color: Colors.white.withOpacity(0.2),
              child: Text(
                'Published by ${widget.user.toString()}',
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
