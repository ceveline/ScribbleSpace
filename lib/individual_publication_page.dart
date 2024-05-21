import 'package:flutter/material.dart';
import 'package:scribblespace/like_button.dart';
import 'package:scribblespace/publication_page.dart';
import 'color_constants.dart';
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

  const IndividualPubPage({
    this.title,
    this.text,
    this.image,
    this.user,
    this.category1,
    this.category2,
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
