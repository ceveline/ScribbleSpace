import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'color_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:image_picker/image_picker.dart';

class EditPublication extends StatefulWidget {
  final String? pub_id;

  const EditPublication({this.pub_id});

  @override
  State<EditPublication> createState() => _EditPublicationState();
}

class _EditPublicationState extends State<EditPublication> {
  late String title = '';
  late String text = '';
  late String user = '';
  late String image = '';
  late String category1 = '';
  late String category2 = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance
          .collection('publications')
          .doc(widget.pub_id)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()!;
        setState(() {
          title = data['Title'];
          text = data['Text'];
          user = data['User'];
          image = data['Image'];
          category1 = data['Category-1'];
          category2 = data['Category-2'];

        });
      }
    } catch (e) {
      print("Error fetching document: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> selectedItems = [];
    TextEditingController _text = TextEditingController();

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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _text,
              // Set the initial value here
            ),

            // Add other form fields for image, category1, category2, etc.
            ElevatedButton(
              onPressed: () {
                // Save changes to Firestore
                saveChanges();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void saveChanges() async {
    try {
      await FirebaseFirestore.instance
          .collection('publications')
          .doc(widget.pub_id)
          .update({
        'Title': title,
        'Text': text,
        // Update other fields as needed
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Publication updated successfully')),
      );
    } catch (e) {
      print("Error updating publication: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update publication')),
      );
    }
  }
}
