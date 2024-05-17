import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribblespace/mainmenu_screen.dart';
import 'color_constants.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // String? title, text;
  TextEditingController _title = TextEditingController();
  TextEditingController _text = TextEditingController();
  List<String> selectedItems = [];
  File? _image;
  final firestore = FirebaseFirestore.instance;

  Future<void> getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image = File(image.path);}
  }

  //https://www.youtube.com/watch?v=BjowvNSdWYE
  // https://www.youtube.com/watch?v=u52TWx41oU4

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text(
          'Create a new post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainMenuScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){getImageFromGallery();},
                child: _image != null ? ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 13),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(_image!, fit: BoxFit.cover,), // Change Image.file to Image.memory
                  ),
                ) :
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  height: 150,
                  decoration: BoxDecoration(
                    color: ColorConstants.darkblue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Title",),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 2,
                      controller: _title,
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(hintText: "Category"),
                            readOnly: true,
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                          SizedBox(height: 8),
                          MultiSelectDropDown(
                            onOptionSelected: (options) {
                              setState(() {
                                selectedItems = options.map<String>((e) => e.label).toList();
                              });
                            },
                            options: const <ValueItem>[
                              ValueItem(label: 'Food', value: 'Food'),
                              ValueItem(label: 'Entertainment', value: 'Entertainment'),
                              ValueItem(label: 'Health & Wellness', value: 'Health & Wellness'),
                              ValueItem(label: 'Sports', value: 'Sports'),
                              ValueItem(label: 'Technology', value: 'Technology'),
                              ValueItem(label: 'Travel', value: 'Travel'),
                              ValueItem(label: 'Pets & Animals', value: 'Pets & Animals'),
                            ],
                            maxItems: 2,
                            selectionType: SelectionType.multi,
                            chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                            dropdownHeight: 300,
                            hint: 'Select here',
                            hintColor: ColorConstants.darkblue,
                            optionTextStyle: const TextStyle(fontSize: 16),
                            selectedOptionIcon: const Icon(Icons.check_circle),
                            fieldBackgroundColor: Colors.transparent,
                            borderColor: Colors.transparent,
                            dropdownBackgroundColor: ColorConstants.darkblue,
                            focusedBorderColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(hintText: "Your text"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                          fontSize: 20
                      ),
                      controller: _text,
                      // onChanged: (val) {
                      //   text = val;
                      // },
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.darkblue,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (_title.text != null && _text.text != null
                              && selectedItems.isNotEmpty && _image != null) {
                            var imageName = DateTime.now().millisecondsSinceEpoch.toString();
                            var storageRef = FirebaseStorage.instance.ref().child('images/$imageName.jpg');
                            var uploadTask = storageRef.putFile(_image!);
                            var downloadUrl = await (await uploadTask).ref.getDownloadURL();
                            var category1 = selectedItems.isNotEmpty ? selectedItems[0] : 'none';
                            var category2 = selectedItems.length > 1 ? selectedItems[1] : 'none';

                            firestore.collection("publications").add({
                              "Title": _title.text,
                              "Text": _text.text,
                              "User": FirebaseAuth.instance.currentUser?.email.toString(),
                              "Category-1": category1,
                              "Category-2": category2,
                              "Image": downloadUrl.toString()
                            });

                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenuScreen()));
                            _title.clear();
                            _text.clear();
                            selectedItems.clear();
                            //   // Compress the image before uploading
                          //   File compressedFile = await compressImage(_image!);
                          //
                          //   // Upload the compressed image to Firebase Storage
                          //   String imageURL = await uploadImage(compressedFile);
                          //   // Add the publication data to Firestore
                          //   FirebaseFirestore.instance.collection('publications').add({
                          //     'title': title,
                          //     'text': text,
                          //     'categories': selectedItems,
                          //     'imageURL': imageURL, // Store the download URL of the image
                          //     // You can add more fields as needed
                          //   }).then((value) {
                          //     // Show a success message
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text('Publication posted successfully'),
                          //         backgroundColor: Colors.green,
                          //       ),
                          //     );
                          //   }).catchError((error) {
                          //     // Show an error message if something goes wrong
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text('Failed to post publication: $error'),
                          //         backgroundColor: Colors.red,
                          //       ),
                          //     );
                          //   });
                          // } else {
                          //   // Show a message if required fields are empty
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text('Please fill in all required fields'),
                          //       backgroundColor: Colors.red,
                          //     ),
                          //   );
                          }
                        },
                        child: Text('Post', style: TextStyle(color: Colors.white, fontSize: 20),)
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
