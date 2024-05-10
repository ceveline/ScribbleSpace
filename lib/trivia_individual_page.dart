import 'package:flutter/material.dart';
import 'package:scribblespace/mainmenu_screen.dart';
import 'trivia_page.dart';
import 'color_constants.dart';

class TriviaIndividualPage extends StatefulWidget {
  final String? category;

  const TriviaIndividualPage({this.category});

  @override
  State<TriviaIndividualPage> createState() => _TriviaIndividualPageState();
}

class _TriviaIndividualPageState extends State<TriviaIndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category} Trivia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.darkblue,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TriviaPage()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        toolbarHeight: 100,
      ),
      backgroundColor: ColorConstants.purple,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 25,),
            Container(
              width: 400,
              height: 300,
              // color: ColorConstants.darkblue,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: ColorConstants.darkblue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      // Shadow color
                      spreadRadius: 2,
                      // Spread radius
                      blurRadius: 5,
                      // Blur radius
                      offset: Offset(0, 3),
                    )
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('A Saxophone is a brass instrument.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                ],
              ),
            ),
            SizedBox(height: 25,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // Shadow color
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 5,
                          // Blur radius
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text('TRUE',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // Shadow color
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 5,
                          // Blur radius
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text('FALSE',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/5,),
                Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // Shadow color
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 5,
                          // Blur radius
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text('TRY AGAIN',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            )
          ],
        )

      ),
    );
  }
}
