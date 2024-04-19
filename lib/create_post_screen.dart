import 'package:flutter/material.dart';
import 'package:scribblespace/mainmenu_screen.dart';
import 'color_constants.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String? title, text;

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.purple,
        appBar: AppBar(
          title: Text('Create a new post',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
              )),
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
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 150,
                  decoration: BoxDecoration(
                      color: ColorConstants.darkblue,
                      borderRadius: BorderRadius.circular(6)),
                  width: MediaQuery.of(context).size.width,
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(hintText: "Title"),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 2,
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: InputDecoration(hintText: "Category"),
                              readOnly: true,
                            ),
                            MultiSelectDropDown(
                              onOptionSelected: (options) {
                                debugPrint(options.toString());
                                selectedItems.add(options.toString());
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
                              // disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
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
                        )
                      ),

                      TextField(
                        decoration: InputDecoration(hintText: "Your text"),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (val) {
                          text = val;
                        },
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
