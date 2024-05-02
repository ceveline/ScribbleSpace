import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicationPage extends StatefulWidget {
  const PublicationPage({super.key});

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Expanded(
      //   child: StreamBuilder(
      //     stream: FirebaseFirestore.instance.collection('publications')
      //         .orderBy("Timestamp", descending: false).snapshots(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData){
      //         return ListView.builder(itemBuilder: (context, index){
      //           var post = snapshot.data!.docs[index];
      //           // return
      //         });
      //       }
      //     },
      //   ),
      // )
    );
  }
}
