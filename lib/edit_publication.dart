import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'individual_publication_page.dart';

class EditPostScreen extends StatefulWidget {
  final String? title;
  final String? text;
  final String? user;
  final String? image;
  final String? category1;
  final String? category2;
  final String? docId;

  EditPostScreen({
    required this.title,
    required this.text,
    required this.user,
    required this.image,
    required this.category1,
    required this.category2,
    required this.docId,
  });

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _text = TextEditingController();
  List<String> selectedItems = [];
  String? _imageUrl;
  File? _image;
  final firestore = FirebaseFirestore.instance;
  bool checkFetch = true;

  Future<void> getImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _imageUrl = null; // Reset the imageUrl as we're now using a new image
      });
    }
  }

  Future<Map<String, String?>> fetchCategories() async {
    if (widget.docId != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
            .collection('publications')
            .doc(widget.docId)
            .get();
        if (snapshot.exists && snapshot.data() != null) {
          var data = snapshot.data();
          return {
            'Category-1': data?['Category-1'] ?? 'none',
            'Category-2': data?['Category-2'] ?? 'none',
          };
        }
      } catch (e) {
        print("Error fetching document: $e");
      }
    }
    // Return 'none' values if document doesn't exist or categories are not present
    return {
      'Category-1': 'none',
      'Category-2': 'none',
    };
  }

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.title);
    _text = TextEditingController(text: widget.text);
    _imageUrl = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        title: Text(
          'Edit post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        backgroundColor: ColorConstants.darkblue,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true); // Indicate that an update has occurred
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
          child: Column(children: <Widget>[
            SizedBox(height: 10),
            GestureDetector(
              onTap: getImageFromGallery,
              child: _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : _imageUrl != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    _imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : Container(
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
                    decoration: InputDecoration(
                      hintText: "Title",
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 2,
                    controller: _title,
                    style: TextStyle(
                      fontSize: 20,
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
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                        FutureBuilder<Map<String, String?>>(
                          future: fetchCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting && checkFetch == true) {
                              return CircularProgressIndicator(); // Show loading indicator while fetching data
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              checkFetch = false;
                              // Data has been fetched successfully
                              Map<String, String?> categories = snapshot.data!;

                              if (categories['Category-1'] != 'none') {
                                selectedItems.add(categories['Category-1']!);
                              }
                              if (categories['Category-2'] != 'none') {
                                selectedItems.add(categories['Category-2']!);
                              }

                              return MultiSelectDropDown(
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
                                selectedOptions: selectedItems.map((item) => ValueItem(label: item, value: item)).toList(),
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
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(hintText: "Your text"),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          controller: _text,
                        ),
                        SizedBox(height: 50),
                        Center(
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.darkblue,
                            ),
                            child: TextButton(
                              onPressed: () async {
                                try {
                                  if (_title.text.isEmpty) {
                                    print("Title is empty");
                                    return;
                                  }

                                  if (_text.text.isEmpty) {
                                    print("Text is empty");
                                    return;
                                  }

                                  if (selectedItems.isEmpty) {
                                    print("Selected items are empty");
                                    return;
                                  }

                                  if (_imageUrl == null && _image == null) {
                                    print("Image is null");
                                    return;
                                  }

                                  if (widget.docId == null) {
                                    print("Document ID is null");
                                    return;
                                  }

                                  print("All conditions passed");

                                  if (_image != null) {
                                    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
                                    var storageRef = FirebaseStorage.instance.ref().child('images/$imageName.jpg');
                                    print("Image Reference: $storageRef");

                                    try {
                                      // If a new image is selected, upload it
                                      var uploadTask = storageRef.putFile(_image!);

                                      // Monitor upload progress
                                      uploadTask.snapshotEvents.listen((event) {
                                        print('Task state: ${event.state}'); // paused, running, etc.
                                        print('Progress: ${(event.bytesTransferred / event.totalBytes) * 100} %');
                                      });

                                      var snapshot = await uploadTask;
                                      _imageUrl = await snapshot.ref.getDownloadURL();
                                      print("Image uploaded: $_imageUrl");
                                    } catch (e) {
                                      print("Error uploading image: $e");
                                      return; // Exit the function if the image upload fails
                                    }
                                  }

                                  var category1 = selectedItems.isNotEmpty ? selectedItems[0] : 'none';
                                  var category2 = selectedItems.length > 1 ? selectedItems[1] : 'none';

                                  print("Updating document with ID: ${widget.docId}");
                                  await FirebaseFirestore.instance.collection("publications").doc(widget.docId).update({
                                    "Title": _title.text,
                                    "Text": _text.text,
                                    "User": FirebaseAuth.instance.currentUser?.email.toString(),
                                    "Category-1": category1,
                                    "Category-2": category2,
                                    "Image": _imageUrl,
                                  });

                                  print("Document updated successfully");
                                  Navigator.pop(context, true); // Indicate that an update has occurred
                                } catch (e) {
                                  print("Error updating document: $e");
                                }
                              },
                              child: Text(
                                'Update',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
