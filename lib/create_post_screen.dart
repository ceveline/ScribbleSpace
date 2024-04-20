import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scribblespace/mainmenu_screen.dart';
import 'color_constants.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String? title, text;
  List<String> selectedItems = [];
  File? pickedFile;

  Future getImageFromGallery() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (img != null) {
        pickedFile = File(img.path);
      }
    });
  }


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
                child: pickedFile != null ? ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 13),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(pickedFile!, fit: BoxFit.cover,),
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
                      onChanged: (val) {
                        title = val;
                      },
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
                              ValueItem(label: 'Health & Wellness', value: 'Health & Wellness'),
                              ValueItem(label: 'Sports', value: 'Sports'),
                              ValueItem(label: 'Technology', value: 'Technology'),
                              ValueItem(label: 'Travel', value: 'Travel'),
                              ValueItem(label: 'Pets & Animals', value: 'Pets & Animals'),
                            ],
                            maxItems: null,
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
                      onChanged: (val) {
                        text = val;
                      },
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.darkblue,
                      ),
                      child: TextButton(
                          onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(selectedItems.isEmpty ? "No categories selected" : selectedItems.join(", ")),
                                backgroundColor: Colors.green,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              ),
                            );
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
