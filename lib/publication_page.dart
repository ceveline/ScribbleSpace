import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scribblespace/individual_publication_page.dart';
import 'color_constants.dart';
import 'mainmenu_screen.dart';

class PublicationPage extends StatefulWidget {
  final String? category;

  const PublicationPage({this.category});

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  List<String> publicationTitles = [];
  List<String> publicationTexts = [];
  List<dynamic> publicationIds = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.darkblue,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenuScreen()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        toolbarHeight: 100,
      ),
      backgroundColor: ColorConstants.purple,
      body: Column(
        children: [
          SizedBox(height: 15,),
          Container(
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white
            ),
            padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                icon: Icon(Icons.search),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('publications').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var filteredDocs = snapshot.data!.docs.where((doc) {
                    var data = doc.data();
                    return data['Category-1'] == widget.category || data['Category-2'] == widget.category;
                  }).toList();

                  if (_searchQuery.isNotEmpty) {
                    filteredDocs = filteredDocs.where((doc) {
                      var post = doc.data();
                      return post['Title'].toString().toLowerCase().contains(_searchQuery) ||
                          post['Text'].toString().toLowerCase().contains(_searchQuery);
                    }).toList();
                  }

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      var post = filteredDocs[index].data();
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IndividualPubPage(
                                title: post['Title'],
                                text: post['Text'],
                                image: post['Image'],
                                user: post['User'],
                                category1: post['Category-1'],
                                category2: post['Category-2'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: ColorConstants.darkblue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: MediaQuery.of(context).size.width / 2.7,
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.network(
                                    post['Image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post['Title'].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "${(post['Text'].toString().length > 100) ?
                                      post['Text'].toString().substring(0, 100) :
                                      post['Text'].toString()}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Author: ${post['User']}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(), // or any other widget
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// class PublicationPage extends StatefulWidget {
//   final String? category;
//
//   const PublicationPage({this.category});
//
//   @override
//   State<PublicationPage> createState() => _PublicationPageState();
// }
//
// class _PublicationPageState extends State<PublicationPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Expanded(
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('publications')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var filteredDocs = snapshot.data!.docs.where((doc) {
//               var data = doc.data() as Map<String, dynamic>;
//               return data['Category-1'] == widget.category || data['Category-2'] == widget.category;
//             }).toList();
//
//             return ListView.builder(
//               itemCount: filteredDocs.length,
//               // itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var post = filteredDocs[index].data() as Map<String, dynamic>;
//                 return Container(
//                   padding: EdgeInsets.all(20),
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     color: ColorConstants.darkblue,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.4),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       )
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         child: Container(
//                           margin: EdgeInsets.symmetric(horizontal: 10),
//                           height: MediaQuery.of(context).size.width / 2,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: Image.network(
//                             post['Image'],
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               post['Title'].toString(),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                             "${(post['Text'].toString().length > 100) ? post['Text']
//                                 .toString().substring(0, 100) : post['Text'].toString()}",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Text(
//                               "Author: ${post['User']}",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }
//
//           return Center(
//             child: CircularProgressIndicator(), // or any other widget
//           );
//         },
//       ),
//     ));
//   }
// }
